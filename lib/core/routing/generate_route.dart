import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/networking/api_service.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/core/routing/route_transition.dart';
import 'package:structure_flutter/presentaions/modules/login/providers/login_provider.dart';
import 'package:structure_flutter/presentaions/modules/login/scene/login_scene.dart';
import 'package:structure_flutter/presentaions/modules/login/use_cases/login_use_case.dart';
import 'package:structure_flutter/presentaions/modules/onboarding/providers/onboarding_provider.dart';
import 'package:structure_flutter/presentaions/modules/onboarding/scene/onboarding_scene.dart';
import 'package:structure_flutter/presentaions/modules/register/providers/register_provider.dart';
import 'package:structure_flutter/presentaions/modules/register/scene/register_scene.dart';
import 'package:structure_flutter/presentaions/modules/register/use_cases/register_use_case.dart';
import 'package:structure_flutter/presentaions/modules/splash/providers/splash_provider.dart';
import 'package:structure_flutter/presentaions/modules/splash/scene/splash_scene.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log('Generating route for: /${settings.name}');
    switch (settings.name) {
      case RoutePath.splash:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider<SplashProvider>(
            create: (context) => SplashProvider(),
            child: const SplashScene(),
          ),
        );
      case RoutePath.onboarding:
        return RouteTransition.generateRoute(
          builder: (context, args) =>
              ChangeNotifierProvider<OnboardingProvider>(
                create: (context) => OnboardingProvider(),
                child: const OnboardingScene(),
              ),
          transition: TransitionType.rightToLeft,
        );
      case RoutePath.login:
        return RouteTransition.generateRoute(
          builder: (context, args) => ChangeNotifierProvider<LoginProvider>(
            create: (context) =>
                LoginProvider(LoginUseCase(ApiService(DioFactory.getDio()))),
            child: const LoginScene(),
          ),
          transition: TransitionType.fadeIn,
        );
      case RoutePath.registerScene:
        return RouteTransition.generateRoute(
          builder: (context, args) =>
              ChangeNotifierProvider<RegisterProvider>(
            create: (context) => RegisterProvider(
                RegisterUseCase(ApiService(DioFactory.getDio()))),
            child: const RegisterScene(),
          ),
          transition: TransitionType.rightToLeft,
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for /${settings.name}')),
          ),
        );
    }
  }
}
