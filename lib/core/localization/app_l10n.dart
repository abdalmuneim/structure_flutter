import 'package:flutter/widgets.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';

/// The app's strings for code that has no `BuildContext`: validators
/// (`AppValidator`), providers (`BaseProvider` subclasses) and error messages.
///
/// Widgets use `context.l10n` instead.
///
/// `LocaleController` keeps this in sync with the language on screen. It
/// starts as English, so code that runs without the app (unit tests) gets the
/// English strings.
class AppL10n {
  AppL10n._();

  static AppLocalizations _current = lookupAppLocalizations(const Locale('en'));

  static AppLocalizations get current => _current;

  static void update(Locale locale) {
    _current = lookupAppLocalizations(locale);
  }
}
