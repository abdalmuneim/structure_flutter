import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentation/modules/onboarding/models/onboarding_item.dart';

class OnboardingProvider extends BaseProvider {
  final pageController = PageController();

  int _currentPage = 0;
  int get currentPage => _currentPage;

  /// A getter, not a field, so the texts follow the current language when
  /// the user switches it on this screen.
  List<OnboardingItem> get items {
    final l10n = AppL10n.current;
    return [
      OnboardingItem(
        title: l10n.onboardingWelcomeTitle,
        description: l10n.onboardingWelcomeDescription,
        icon: Icons.local_hospital,
      ),
      OnboardingItem(
        title: l10n.onboardingBookTitle,
        description: l10n.onboardingBookDescription,
        icon: Icons.calendar_month,
      ),
      OnboardingItem(
        title: l10n.onboardingStartTitle,
        description: l10n.onboardingStartDescription,
        icon: Icons.rocket_launch,
      ),
    ];
  }

  bool get isLastPage => _currentPage == items.length - 1;

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (isLastPage) return;
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> complete() async {
    await SharedPrefHelper.setData(SharedPrefKeys.onboardingCompleted, true);
    navigateTo(RoutePath.login, clearStack: true);
  }

  Future<void> skip() => complete();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
