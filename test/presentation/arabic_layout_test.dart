import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/core/routing/generate_route.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';
import 'package:structure_flutter/presentation/components/utils/ui/theme.dart';
import 'package:structure_flutter/presentation/modules/onboarding/scene/onboarding_scene.dart';

const _phone = '+201012345678';

/// The screens only build here; nothing calls the API.
class _UnusedAuthRepo implements AuthRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('not used by layout tests');
}

/// Opens [route] in Arabic on a small (320×640) phone. Any RenderFlex
/// overflow fails the test.
Future<void> _openInArabic(
  WidgetTester tester,
  String route, {
  Object? arguments,
}) async {
  tester.view.physicalSize = const Size(320, 640);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  AppL10n.update(const Locale('ar'));

  final navigatorKey = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    Provider<AuthRepo>.value(
      value: _UnusedAuthRepo(),
      child: MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: AppTheme().light(const Locale('ar')),
        navigatorKey: navigatorKey,
        home: const SizedBox(),
        onGenerateRoute: GenerateRoute.generateRoute,
      ),
    ),
  );
  navigatorKey.currentState!.pushNamed(route, arguments: arguments);
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// [text] wrapped in the isolate marks that `context.ltr` adds in RTL.
String _isolated(String text) =>
    '${String.fromCharCode(0x2066)}$text${String.fromCharCode(0x2069)}';

void main() {
  tearDown(() => AppL10n.update(const Locale('en')));

  testWidgets('onboarding fits and slides in from the left', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        navigatorKey: navigatorKey,
        home: const SizedBox(),
        onGenerateRoute: GenerateRoute.generateRoute,
      ),
    );

    navigatorKey.currentState!.pushNamed(RoutePath.onboarding);
    await tester.pump(); // the new route's first frame is built offstage
    // Early in the "rightToLeft" transition.
    await tester.pump(const Duration(milliseconds: 30));
    final slide = tester.widget<SlideTransition>(
      find
          .ancestor(
            of: find.byType(OnboardingScene),
            matching: find.byType(SlideTransition),
          )
          .first,
    );
    expect(slide.position.value.dx, lessThan(0)); // starts off the left edge

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('phone screen fits; the phone field stays left-to-right', (
    tester,
  ) async {
    await _openInArabic(tester, RoutePath.login);

    expect(find.text('تسجيل الدخول'), findsOneWidget);
    final field = find.byType(TextFormField);
    expect(Directionality.of(tester.element(field)), TextDirection.ltr);
    // The label above it still follows the screen.
    expect(
      Directionality.of(tester.element(find.text('رقم الهاتف'))),
      TextDirection.rtl,
    );
  });

  testWidgets('register form fits; the phone keeps its order', (tester) async {
    await _openInArabic(tester, RoutePath.registerScene, arguments: _phone);

    expect(find.text('أنشئ حسابًا للرقم ${_isolated(_phone)}'), findsOneWidget);
    expect(find.text('ذكر'), findsOneWidget);
    expect(find.text('أنثى'), findsOneWidget);
  });

  testWidgets('OTP screen fits, with Arabic plural and countdown', (
    tester,
  ) async {
    await _openInArabic(tester, RoutePath.loginOtp, arguments: _phone);

    expect(find.text('أدخل رمز التحقق المكوّن من 4 أرقام'), findsOneWidget);
    expect(
      find.text('أرسلنا رمز التحقق إلى ${_isolated(_phone)}'),
      findsOneWidget,
    );
    expect(
      find.textContaining(RegExp(r'^يمكنك إعادة الإرسال بعد \d\d:\d\d$')),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox()); // stops the countdown timer
  });

  testWidgets('main tabs and bottom bar fit', (tester) async {
    await _openInArabic(tester, RoutePath.main);

    for (final tab in ['الإشعارات', 'حسابي', 'الإعدادات', 'الرئيسية']) {
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();
    }
    expect(find.text('اللغة'), findsNothing); // back on Home
  });
}
