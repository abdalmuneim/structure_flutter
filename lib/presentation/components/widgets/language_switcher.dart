import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/helpers/constants.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
import 'package:structure_flutter/core/localization/locale_controller.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';
import 'package:structure_flutter/presentation/components/utils/ui/ui.dart';

/// Switches English ⇄ Arabic in one tap, for screens before login.
///
/// Shows the language it switches *to*, written in that language
/// ("العربية" / "English"), so someone who can't read the current language
/// can still find it.
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final target = isArabic ? const Locale('en') : const Locale('ar');

    return Tooltip(
      message: context.l10n.languageChange,
      child: TextButton.icon(
        onPressed: () => context.read<LocaleController>().setLocale(target),
        style: TextButton.styleFrom(foregroundColor: color),
        icon: const Icon(Icons.translate, size: 18),
        label: Text(
          _languageName(context.l10n, target),
          style: TextStyle(
            fontFamily: _fontFor(target),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Settings row showing the current language; opens a picker on tap.
class LanguageSettingTile extends StatelessWidget {
  const LanguageSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListTile(
      leading: const Icon(Icons.language, color: AppColors.primary),
      title: Text(l10n.settingsLanguage),
      subtitle: Text(_languageName(l10n, Localizations.localeOf(context))),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showLanguagePicker(context),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final controller = context.read<LocaleController>();

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final l10n = sheetContext.l10n;
        final current = Localizations.localeOf(sheetContext).languageCode;

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Text(
                  l10n.settingsChooseLanguage,
                  style: Theme.of(sheetContext).textTheme.headlineSmall,
                ),
              ),
              for (final locale in AppLocalizations.supportedLocales)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  title: Text(
                    _languageName(l10n, locale),
                    style: TextStyle(fontFamily: _fontFor(locale)),
                  ),
                  trailing: locale.languageCode == current
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    controller.setLocale(locale);
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

String _languageName(AppLocalizations l10n, Locale locale) =>
    switch (locale.languageCode) {
      'ar' => l10n.languageArabic,
      _ => l10n.languageEnglish,
    };

/// A language's name is drawn in that language's font, whatever the current
/// one is (Poppins has no Arabic letters).
String _fontFor(Locale locale) => locale.languageCode == 'ar'
    ? AppConstants.arabicAppFont
    : AppConstants.englishAppFont;
