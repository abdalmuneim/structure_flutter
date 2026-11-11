import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/routing/route_path.dart';

class SplashProvider extends BaseProvider {
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    final onboardingDone = await SharedPrefHelper.getBool(
      SharedPrefKeys.onboardingCompleted,
    );

    if (onboardingDone != true) {
      navigateTo(RoutePath.onboarding, clearStack: true);
      return;
    }

    // A token alone isn't enough: register saves one before the phone is
    // confirmed. isLoggedIn is set after login or after that confirmation.
    final bool isLoggedIn = await SharedPrefHelper.getBool(
      SharedPrefKeys.isLoggedIn,
    );
    final String token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );

    navigateTo(
      isLoggedIn && token.isNotEmpty ? RoutePath.main : RoutePath.login,
      clearStack: true,
    );
  }
}
