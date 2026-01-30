import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';
import 'package:structure_flutter/core/routing/route_path.dart';

class SplashProvider extends BaseProvider {
  Future<void> init(BuildContext context) async {
    final navigator = Navigator.of(context);

    await Future.delayed(const Duration(seconds: 2));

    final onboardingDone = await SharedPrefHelper.getBool(
      SharedPrefKeys.onboardingCompleted,
    );

    if (onboardingDone != true) {
      navigator.pushNamedAndRemoveUntil(
        RoutePath.onboarding,
        (route) => false,
      );
      return;
    }

    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );

    if (token != null && token.toString().isNotEmpty) {
      DioFactory.setTokenIntoHeaderAfterLogin(token);
      navigator.pushNamedAndRemoveUntil(RoutePath.main, (route) => false);
    } else {
      navigator.pushNamedAndRemoveUntil(RoutePath.login, (route) => false);
    }
  }
}
