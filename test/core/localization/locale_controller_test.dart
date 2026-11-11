import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/core/localization/locale_controller.dart';

Future<String> _savedLanguage() async =>
    await SharedPrefHelper.getString(SharedPrefKeys.userLanguage);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));
  // AppL10n is global: put English back for the other tests.
  tearDown(() => AppL10n.update(const Locale('en')));

  group('first launch (nothing saved)', () {
    test('Arabic device opens in Arabic and saves it', () async {
      final controller = LocaleController(
        savedLanguageCode: '',
        deviceLocale: const Locale('ar', 'EG'),
      );
      await pumpEventQueue();

      expect(controller.locale, const Locale('ar'));
      expect(controller.isArabic, isTrue);
      expect(AppL10n.current.localeName, 'ar');
      expect(await _savedLanguage(), 'ar');
    });

    test('English device opens in English', () async {
      final controller = LocaleController(
        deviceLocale: const Locale('en', 'US'),
      );
      await pumpEventQueue();

      expect(controller.locale, const Locale('en'));
      expect(await _savedLanguage(), 'en');
    });

    test('unsupported device language falls back to English', () async {
      final controller = LocaleController(deviceLocale: const Locale('fr'));
      await pumpEventQueue();

      expect(controller.locale, const Locale('en'));
      expect(await _savedLanguage(), 'en');
    });
  });

  test('the saved language wins over the device language', () async {
    SharedPreferences.setMockInitialValues({SharedPrefKeys.userLanguage: 'ar'});

    final controller = LocaleController(
      savedLanguageCode: 'ar',
      deviceLocale: const Locale('en'),
    );

    expect(controller.locale, const Locale('ar'));
    expect(AppL10n.current.localeName, 'ar');
  });

  test('setLocale switches, notifies, and saves the choice', () async {
    final controller = LocaleController(
      savedLanguageCode: 'en',
      deviceLocale: const Locale('en'),
    );
    var notified = 0;
    controller.addListener(() => notified++);

    await controller.setLocale(const Locale('ar', 'EG'));

    expect(controller.locale, const Locale('ar'));
    expect(AppL10n.current.localeName, 'ar');
    expect(notified, 1);
    expect(await _savedLanguage(), 'ar');
  });

  test('setLocale ignores the current and unsupported languages', () async {
    final controller = LocaleController(
      savedLanguageCode: 'en',
      deviceLocale: const Locale('en'),
    );
    var notified = 0;
    controller.addListener(() => notified++);

    await controller.setLocale(const Locale('en'));
    await controller.setLocale(const Locale('fr'));

    expect(controller.locale, const Locale('en'));
    expect(notified, 0);
  });

  test('toggle switches English <-> Arabic', () async {
    final controller = LocaleController(
      savedLanguageCode: 'en',
      deviceLocale: const Locale('en'),
    );

    await controller.toggle();
    expect(controller.locale, const Locale('ar'));

    await controller.toggle();
    expect(controller.locale, const Locale('en'));
    expect(await _savedLanguage(), 'en');
  });
}
