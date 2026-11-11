import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';

/// The app language (English or Arabic), app-wide, above `MaterialApp`.
///
/// - Starts with the saved language; if none is saved, the device language
///   when it is supported, otherwise English.
/// - [setLocale] / [toggle] switch the language on screen at once (no
///   restart) and save it in [SharedPrefKeys.userLanguage].
///
/// That same key is what the API layer sends (`Accept-Language` header and the
/// login/register `language` field), so the server always answers in the
/// language the user sees.
class LocaleController extends ChangeNotifier {
  /// [savedLanguageCode] is the value read from [SharedPrefKeys.userLanguage]
  /// ('' or null when nothing is saved). [deviceLocale] defaults to the
  /// platform's; tests pass their own.
  LocaleController({String? savedLanguageCode, Locale? deviceLocale})
    : _locale = _initialLocale(
        savedLanguageCode,
        deviceLocale ?? PlatformDispatcher.instance.locale,
      ) {
    AppL10n.update(_locale);
    if (!isSupported(savedLanguageCode)) {
      // First launch: save the default so the API uses it too.
      unawaited(_save(_locale));
    }
  }

  Locale _locale;

  Locale get locale => _locale;

  bool get isArabic => _locale.languageCode == 'ar';

  Future<void> setLocale(Locale locale) async {
    final code = locale.languageCode;
    if (!isSupported(code) || code == _locale.languageCode) return;

    _locale = Locale(code);
    AppL10n.update(_locale);
    notifyListeners();
    await _save(_locale);
  }

  /// Switches English ⇄ Arabic.
  Future<void> toggle() =>
      setLocale(isArabic ? const Locale('en') : const Locale('ar'));

  static bool isSupported(String? languageCode) => AppLocalizations
      .supportedLocales
      .any((locale) => locale.languageCode == languageCode);

  static Locale _initialLocale(String? savedLanguageCode, Locale device) {
    if (isSupported(savedLanguageCode)) return Locale(savedLanguageCode!);
    if (isSupported(device.languageCode)) return Locale(device.languageCode);
    return const Locale('en');
  }

  Future<void> _save(Locale locale) async {
    try {
      await SharedPrefHelper.setData(
        SharedPrefKeys.userLanguage,
        locale.languageCode,
      );
    } catch (error) {
      // The language on screen has already changed; only the saved copy
      // failed, so the next launch falls back to the default.
      debugPrint('LocaleController: could not save the language: $error');
    }
  }
}
