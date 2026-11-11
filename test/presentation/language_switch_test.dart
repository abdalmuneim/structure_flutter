import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/main.dart';
import 'package:structure_flutter/presentation/modules/onboarding/scene/onboarding_scene.dart';

/// Pumps frames for 1 second (spinners never settle, so no pumpAndSettle).
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

TextDirection _directionOf(WidgetTester tester) =>
    Directionality.of(tester.element(find.byType(OnboardingScene)));

Future<void> _openOnboarding(WidgetTester tester, String savedLanguage) async {
  SharedPreferences.setMockInitialValues({
    SharedPrefKeys.userLanguage: savedLanguage,
  });
  FlutterSecureStorage.setMockInitialValues(<String, String>{});

  await tester.pumpWidget(MyApp(savedLanguageCode: savedLanguage));
  await tester.pump(const Duration(seconds: 2)); // splash delay
  await _settle(tester);
}

void main() {
  tearDown(() => AppL10n.update(const Locale('en')));

  testWidgets('a saved Arabic choice opens the app right-to-left', (
    tester,
  ) async {
    await _openOnboarding(tester, 'ar');

    expect(_directionOf(tester), TextDirection.rtl);
    expect(find.text('English'), findsOneWidget); // the toggle's target
  });

  testWidgets('the toggle switches the whole app at once and saves it', (
    tester,
  ) async {
    await _openOnboarding(tester, 'en');
    expect(_directionOf(tester), TextDirection.ltr);

    await tester.tap(find.text('العربية'));
    await _settle(tester);

    expect(_directionOf(tester), TextDirection.rtl);
    expect(find.text('English'), findsOneWidget);
    expect(await SharedPrefHelper.getString(SharedPrefKeys.userLanguage), 'ar');
    // The page texts come from the provider (AppL10n), not the widget tree.
    expect(find.text('مرحبًا بك في VCare'), findsOneWidget);
  });

  testWidgets('Arabic: onboarding -> phone screen -> Arabic form error', (
    tester,
  ) async {
    await _openOnboarding(tester, 'ar');
    expect(find.text('مرحبًا بك في VCare'), findsOneWidget);
    expect(find.text('1 من 3'), findsOneWidget);

    await tester.tap(find.text('تخطٍّ'));
    await _settle(tester);
    expect(find.text('تسجيل الدخول'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '123');
    await tester.tap(find.text('ابدأ الآن'));
    await _settle(tester);
    expect(find.text('أدخل رقم هاتف صحيحًا'), findsWidgets);
  });
}
