import 'package:flutter/widgets.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  /// The app's strings in the current language, e.g. `context.l10n.appTitle`.
  ///
  /// Needs `AppLocalizations.localizationsDelegates` on the `MaterialApp`.
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// [value] (a phone number, code, email…) kept left-to-right and in one
  /// piece inside a translated sentence. In Arabic, "+201012345678" would
  /// otherwise be drawn as "201012345678+".
  ///
  /// Wraps it in Unicode isolate marks (LRI … PDI) only in a right-to-left
  /// language; elsewhere the value is returned unchanged.
  String ltr(String value) => Directionality.of(this) == TextDirection.rtl
      ? '\u2066$value\u2069'
      : value;
}
