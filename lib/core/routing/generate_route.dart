import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/core/routing/route_transition.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';
import 'package:structure_flutter/domain/use_cases/handshake_use_case.dart';
import 'package:structure_flutter/domain/use_cases/login_use_case.dart';
import 'package:structure_flutter/domain/use_cases/register_use_case.dart';
import 'package:structure_flutter/domain/use_cases/resend_otp_use_case.dart';
import 'package:structure_flutter/domain/use_cases/verify_registration_otp_use_case.dart';
import 'package:structure_flutter/presentation/modules/home/providers/home_provider.dart';
import 'package:structure_flutter/presentation/modules/login/providers/login_provider.dart';
import 'package:structure_flutter/presentation/modules/login/scene/login_scene.dart';
import 'package:structure_flutter/presentation/modules/main/models/main_tab.dart';
import 'package:structure_flutter/presentation/modules/main/providers/main_provider.dart';
import 'package:structure_flutter/presentation/modules/main/scene/main_scene.dart';
import 'package:structure_flutter/presentation/modules/notifications/providers/notifications_provider.dart';
import 'package:structure_flutter/presentation/modules/onboarding/providers/onboarding_provider.dart';
import 'package:structure_flutter/presentation/modules/onboarding/scene/onboarding_scene.dart';
import 'package:structure_flutter/presentation/modules/otp/models/otp_mode.dart';
import 'package:structure_flutter/presentation/modules/otp/providers/otp_provider.dart';
import 'package:structure_flutter/presentation/modules/otp/scene/otp_scene.dart';
import 'package:structure_flutter/presentation/modules/profile/providers/profile_provider.dart';
import 'package:structure_flutter/presentation/modules/register/providers/register_provider.dart';
import 'package:structure_flutter/presentation/modules/register/scene/register_scene.dart';
import 'package:structure_flutter/presentation/modules/settings/providers/settings_provider.dart';
import 'package:structure_flutter/presentation/modules/splash/providers/splash_provider.dart';
import 'package:structure_flutter/presentation/modules/splash/scene/splash_scene.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log('Generating route for: /${settings.name}');
    switch (settings.name) {
      case RoutePath.splash:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => ChangeNotifierProvider<SplashProvider>(
            create: (context) => SplashProvider(),
            child: const SplashScene(),
          ),
        );
      case RoutePath.onboarding:
        return RouteTransition.generateRoute(
          settings: settings,
          builder: (context, args) =>
              ChangeNotifierProvider<OnboardingProvider>(
                create: (context) => OnboardingProvider(),
                child: const OnboardingScene(),
              ),
          transition: TransitionType.rightToLeft,
        );
      // Auth flow (same as lawmate):
      // login (phone) ─ existing account ─> loginOtp ───────────────> main
      //               └ new account ─> registerScene ─> registerOtp ─> main
      // The phone number (+20…) is passed as the argument to each step.
      case RoutePath.login:
        return RouteTransition.generateRoute(
          settings: settings,
          builder: (context, args) => ChangeNotifierProvider<LoginProvider>(
            create: (context) =>
                LoginProvider(HandshakeUseCase(context.read<AuthRepo>())),
            child: const LoginScene(),
          ),
          transition: TransitionType.fadeIn,
        );
      case RoutePath.registerScene:
        return RouteTransition.generateRoute(
          settings: settings,
          builder: (context, args) =>
              ChangeNotifierProvider<RegisterProvider>(
            create: (context) => RegisterProvider(
              RegisterUseCase(context.read<AuthRepo>()),
              phone: args as String,
            ),
            child: const RegisterScene(),
          ),
          transition: TransitionType.rightToLeft,
        );
      case RoutePath.loginOtp:
      case RoutePath.registerOtp:
        return RouteTransition.generateRoute(
          settings: settings,
          builder: (context, args) => ChangeNotifierProvider<OtpProvider>(
            create: (context) {
              final authRepo = context.read<AuthRepo>();
              return OtpProvider(
                mode: settings.name == RoutePath.loginOtp
                    ? OtpMode.login
                    : OtpMode.registration,
                phone: args as String,
                loginUseCase: LoginUseCase(authRepo),
                verifyRegistrationOtpUseCase: VerifyRegistrationOtpUseCase(
                  authRepo,
                ),
                resendOtpUseCase: ResendOtpUseCase(authRepo),
              );
            },
            child: const OtpScene(),
          ),
          transition: TransitionType.downToUp,
        );
      case RoutePath.main:
        // Optional argument: the tab to open, e.g.
        // navigateTo(RoutePath.main, arguments: MainTab.notifications).
        // The tab providers live as long as the main route, so each tab
        // keeps its state while the user switches between them.
        return RouteTransition.generateRoute(
          settings: settings,
          builder: (context, args) => MultiProvider(
            providers: [
              ChangeNotifierProvider<MainProvider>(
                create: (context) => MainProvider(
                  initialTab: args is MainTab ? args : MainTab.home,
                ),
              ),
              ChangeNotifierProvider<HomeProvider>(
                create: (context) => HomeProvider(),
              ),
              ChangeNotifierProvider<NotificationsProvider>(
                create: (context) => NotificationsProvider(),
              ),
              ChangeNotifierProvider<ProfileProvider>(
                create: (context) => ProfileProvider(),
              ),
              ChangeNotifierProvider<SettingsProvider>(
                create: (context) => SettingsProvider(),
              ),
            ],
            child: const MainScene(),
          ),
          transition: TransitionType.fadeIn,
        );
      default:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for /${settings.name}')),
          ),
        );
    }
  }
}
