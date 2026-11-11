import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/app_dependencies.dart';
import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/environment/build_environment.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
import 'package:structure_flutter/core/localization/locale_controller.dart';
import 'package:structure_flutter/core/routing/generate_route.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';
import 'package:structure_flutter/presentation/components/utils/ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Reading the keys here makes a misconfigured flavor fail at startup.
  final keys = BuildEnvironment.keys;
  debugPrint('Flavor: ${BuildEnvironment.flavor.name}, API: ${keys.apiUrl}');

  // Read before the first frame so the app opens in the saved language.
  final String savedLanguageCode = await SharedPrefHelper.getString(
    SharedPrefKeys.userLanguage,
  );

  runApp(MyApp(savedLanguageCode: savedLanguageCode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedLanguageCode});

  /// The language saved from the previous run ('' or null when none).
  final String? savedLanguageCode;

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      savedLanguageCode: savedLanguageCode,
      // Rebuilds MaterialApp when the language changes, so the whole app
      // switches at once (strings, text direction, font).
      child: Consumer<LocaleController>(
        builder: (context, localeController, _) => MaterialApp(
          onGenerateTitle: (context) => context.l10n.appTitle,
          locale: localeController.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          navigatorKey: BaseUseCase.navigatorKey,
          initialRoute: RoutePath.splash,
          onGenerateRoute: GenerateRoute.generateRoute,
          theme: AppTheme().light(localeController.locale),
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
        ),
      ),
    );
  }
}
