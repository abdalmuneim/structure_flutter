import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/app_dependencies.dart';
import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/environment/build_environment.dart';
import 'package:structure_flutter/core/routing/generate_route.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentation/components/utils/ui/theme.dart';

void main() {
  // Reading the keys here makes a misconfigured flavor fail at startup.
  final keys = BuildEnvironment.keys;
  debugPrint('Flavor: ${BuildEnvironment.flavor.name}, API: ${keys.apiUrl}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: BaseUseCase.navigatorKey,
        initialRoute: RoutePath.splash,
        onGenerateRoute: GenerateRoute.generateRoute,
        theme: AppTheme().light(),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}
