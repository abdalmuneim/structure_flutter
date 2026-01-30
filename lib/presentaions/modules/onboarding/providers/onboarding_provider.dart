import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentaions/modules/onboarding/models/onboarding_item.dart';

class OnboardingProvider extends BaseProvider {
  final pageController = PageController();

  int _currentPage = 0;
  int get currentPage => _currentPage;

  final List<OnboardingItem> items = const [
    OnboardingItem(
      title: 'Welcome to VCare',
      description: 'Your health is our priority. Get access to top doctors and medical services.',
      icon: Icons.local_hospital,
    ),
    OnboardingItem(
      title: 'Book Appointments',
      description: 'Schedule appointments with specialists easily and quickly.',
      icon: Icons.calendar_month,
    ),
    OnboardingItem(
      title: 'Get Started',
      description: 'Create your account and start your health journey today.',
      icon: Icons.rocket_launch,
    ),
  ];

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

  Future<void> complete(BuildContext context) async {
    final navigator = Navigator.of(context);
    await SharedPrefHelper.setData(SharedPrefKeys.onboardingCompleted, true);
    navigator.pushNamedAndRemoveUntil(RoutePath.login, (route) => false);
  }

  Future<void> skip(BuildContext context) async {
    await complete(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
