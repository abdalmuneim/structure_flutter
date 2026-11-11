import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/routing/generate_route.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';
import 'package:structure_flutter/main.dart';

const _localPhone = '01012345678';
const _apiPhone = '+201012345678';

/// Records what the screens ask for and answers like the server would.
class _FakeAuthRepo implements AuthRepo {
  _FakeAuthRepo({this.isRegistered = true, this.handshakeError});

  final bool isRegistered;
  final Object? handshakeError;

  String? handshakePhone;
  ({String phone, String otpCode})? loginCall;
  RegisterRequest? registerRequest;
  String? verifiedCode;
  int resendCount = 0;

  @override
  Future<bool> handshake(String phone) async {
    handshakePhone = phone;
    if (handshakeError != null) throw handshakeError!;
    return isRegistered;
  }

  @override
  Future<User> login({required String phone, required String otpCode}) async {
    loginCall = (phone: phone, otpCode: otpCode);
    return const User(id: 1);
  }

  @override
  Future<User> register(RegisterRequest request) async {
    registerRequest = request;
    return const User(id: 1);
  }

  @override
  Future<User> verifyRegistrationOtp(String otpCode) async {
    verifiedCode = otpCode;
    return const User(id: 1);
  }

  @override
  Future<void> resendOtp() async => resendCount++;
}

/// Pumps frames for 1 second so effects, navigation and transitions finish.
/// (Can't use pumpAndSettle: spinners and the OTP countdown never settle.)
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Shows the phone screen with [repo] in place of the real AuthRepo, on a
/// tall screen so the whole register form fits.
Future<void> _openLogin(WidgetTester tester, AuthRepo repo) async {
  tester.view.physicalSize = const Size(1200, 3000);
  tester.view.devicePixelRatio = 1.5;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    Provider<AuthRepo>.value(
      value: repo,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: RoutePath.login,
        onGenerateRoute: GenerateRoute.generateRoute,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    ),
  );
  await _settle(tester);
}

Future<void> _submitPhone(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField), _localPhone);
  await tester.tap(find.text('Get Started'));
  await _settle(tester);
}

Future<void> _launchApp(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pump(const Duration(seconds: 2)); // splash delay
  await _settle(tester);
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
  });

  group('splash', () {
    testWidgets('first launch: onboarding -> skip -> phone screen', (
      tester,
    ) async {
      await _launchApp(tester);
      expect(find.text('Skip'), findsOneWidget);

      await tester.tap(find.text('Skip'));
      await _settle(tester);

      expect(find.text('Let’s Sign In'), findsOneWidget);
    });

    testWidgets('logged in: opens main', (tester) async {
      SharedPreferences.setMockInitialValues({
        SharedPrefKeys.onboardingCompleted: true,
        SharedPrefKeys.isLoggedIn: true,
      });
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        SharedPrefKeys.userToken: 'abc',
      });

      await _launchApp(tester);

      expect(find.text('Your home feed'), findsOneWidget);
    });

    testWidgets('registered but code not confirmed: phone screen', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({
        SharedPrefKeys.onboardingCompleted: true,
      });
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        SharedPrefKeys.userToken: 'abc',
      });

      await _launchApp(tester);

      expect(find.text('Let’s Sign In'), findsOneWidget);
    });
  });

  group('phone screen', () {
    testWidgets('invalid phone shows an error and calls nothing', (
      tester,
    ) async {
      final repo = _FakeAuthRepo();
      await _openLogin(tester, repo);

      await tester.enterText(find.byType(TextFormField), '0101');
      await tester.tap(find.text('Get Started'));
      await _settle(tester);

      // AppTextField shows the message below the field and also keeps
      // a hidden copy in the TextFormField's own error slot.
      expect(find.text('Enter a valid phone number'), findsWidgets);
      expect(repo.handshakePhone, isNull);
    });

    testWidgets('server error is shown and the screen stays', (tester) async {
      final options = RequestOptions(path: '/handshake');
      final repo = _FakeAuthRepo(
        handshakeError: DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: options,
            statusCode: 422,
            data: {'message': 'Phone is blocked'},
          ),
        ),
      );
      await _openLogin(tester, repo);

      await _submitPhone(tester);

      expect(find.text('Phone is blocked'), findsOneWidget);
      expect(find.text('Let’s Sign In'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.pump(const Duration(seconds: 6)); // let the toast close
      await _settle(tester);
    });
  });

  testWidgets('existing account: phone -> OTP -> main', (tester) async {
    final repo = _FakeAuthRepo(isRegistered: true);
    await _openLogin(tester, repo);

    await _submitPhone(tester);
    expect(repo.handshakePhone, _apiPhone);
    expect(find.text('Enter 4 digit OTP Code'), findsOneWidget);
    expect(find.text('We sent a code to $_apiPhone'), findsOneWidget);

    // Submits by itself once 4 digits are typed.
    await tester.enterText(find.byType(TextFormField), '1234');
    await _settle(tester);

    expect(repo.loginCall, (phone: _apiPhone, otpCode: '1234'));
    expect(find.text('Your home feed'), findsOneWidget);
  });

  testWidgets('new account: phone -> register -> OTP -> main', (tester) async {
    final repo = _FakeAuthRepo(isRegistered: false);
    await _openLogin(tester, repo);

    await _submitPhone(tester);
    expect(find.text('Sign Up For Free'), findsOneWidget);
    expect(find.text('Create your account for $_apiPhone'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ahmed');
    await tester.enterText(fields.at(1), 'Ali');
    await tester.enterText(fields.at(2), 'ahmed@test.com');
    await tester.tap(fields.at(3)); // opens the date picker
    await _settle(tester);
    await tester.tap(find.text('OK')); // latest allowed date: 20 years ago
    await _settle(tester);
    await tester.tap(find.text('Male'));
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await _settle(tester);

    final request = repo.registerRequest!;
    expect(request.firstName, 'Ahmed');
    expect(request.lastName, 'Ali');
    expect(request.email, 'ahmed@test.com');
    expect(request.phone, _apiPhone);
    expect(request.gender, 'male');
    expect(request.birthdate, matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
    expect(find.text('Sign Up Successful!'), findsOneWidget);

    await tester.tap(find.text('Verify Phone Number'));
    await _settle(tester);
    expect(find.text('Enter 4 digit OTP Code'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '5678');
    await _settle(tester);

    expect(repo.verifiedCode, '5678');
    expect(repo.loginCall, isNull);
    expect(find.text('Your home feed'), findsOneWidget);
  });

  testWidgets('register needs the terms and a gender', (tester) async {
    final repo = _FakeAuthRepo(isRegistered: false);
    await _openLogin(tester, repo);
    await _submitPhone(tester);

    await tester.tap(find.text('Continue'));
    await _settle(tester);
    expect(
      find.text('You must accept the terms and conditions to proceed'),
      findsOneWidget,
    );

    await tester.tap(find.byType(Checkbox));
    await tester.tap(find.text('Continue'));
    await _settle(tester);
    expect(find.text('Gender required'), findsOneWidget);
    expect(repo.registerRequest, isNull);

    await tester.pump(const Duration(seconds: 6)); // let the toast close
    await _settle(tester);
  });

  testWidgets('OTP can be resent after 60 seconds', (tester) async {
    final repo = _FakeAuthRepo();
    await _openLogin(tester, repo);
    await _submitPhone(tester);

    expect(find.text('You can send again after 01:00'), findsOneWidget);
    expect(find.text('Resend OTP'), findsNothing);

    await tester.pump(const Duration(seconds: 60));
    await tester.pump();
    await tester.tap(find.text('Resend OTP'));
    await _settle(tester);

    expect(repo.resendCount, 1);
    expect(find.textContaining('You can send again after 00:5'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3)); // let the toast close
    await tester.pumpWidget(const SizedBox()); // stops the countdown timer
  });

  testWidgets('back from the registration OTP returns to the phone screen', (
    tester,
  ) async {
    final repo = _FakeAuthRepo(isRegistered: false);
    await _openLogin(tester, repo);
    await _submitPhone(tester);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ahmed');
    await tester.enterText(fields.at(1), 'Ali');
    await tester.enterText(fields.at(2), 'ahmed@test.com');
    await tester.tap(fields.at(3));
    await _settle(tester);
    await tester.tap(find.text('OK'));
    await _settle(tester);
    await tester.tap(find.text('Female'));
    await tester.tap(find.byType(Checkbox));
    await tester.tap(find.text('Continue'));
    await _settle(tester);
    await tester.tap(find.text('Verify Phone Number'));
    await _settle(tester);

    await tester.tap(find.byTooltip('Back'));
    await _settle(tester);

    expect(find.text('Let’s Sign In'), findsOneWidget);
    expect(find.text('Enter 4 digit OTP Code'), findsNothing);
  });
}
