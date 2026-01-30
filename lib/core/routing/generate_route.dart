import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/core/routing/route_transition.dart';
import 'package:structure_flutter/presentaions/modules/login/providers/login_provider.dart';
import 'package:structure_flutter/presentaions/modules/login/scene/login_scene.dart';
import 'package:structure_flutter/presentaions/modules/splash/providers/splash_provider.dart';
import 'package:structure_flutter/presentaions/modules/splash/scene/splash_scene.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // FirebaseAnalytics.instance.setCurrentScreen(screenName: settings.name);
    switch (settings.name) {
      case RoutePath.locationPermission:
        return RouteTransition.generateRoute(
          builder: (context, args) => ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider(),
            child: const LoginScene(),
          ),
          transition: TransitionType.downToUp,
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider<SplashProvider>(
            create: (context) => SplashProvider(),
            child: const SplashScene(),
          ),
        );
    }
  }
}
