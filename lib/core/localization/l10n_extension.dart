import 'package:flutter/widgets.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  /// The app's strings in the current language, e.g. `context.l10n.appTitle`.
  ///
  /// Needs `AppLocalizations.localizationsDelegates` on the `MaterialApp`.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
