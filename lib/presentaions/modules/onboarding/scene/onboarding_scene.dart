import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_button.dart';
import 'package:structure_flutter/presentaions/modules/onboarding/models/onboarding_item.dart';
import 'package:structure_flutter/presentaions/modules/onboarding/providers/onboarding_provider.dart';

class OnboardingScene extends BaseScene<OnboardingProvider, void> {
  const OnboardingScene({super.key});

  @override
  BaseSceneState<OnboardingProvider, void> createState() =>
      _OnboardingSceneState();
}

class _OnboardingSceneState
    extends BaseSceneState<OnboardingProvider, void> {
  // Accent colors per page
  static const _pageAccentColors = [
    AppColors.primary,          // Page 1: primary blue
    AppColors.activeGreen,      // Page 2: teal/green
    Color(0xFFFED709),          // Page 3: secondary gold
  ];

  @override
  Widget buildWidget(BuildContext context, OnboardingProvider p) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => provider.skip(context),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: p.pageController,
                onPageChanged: p.onPageChanged,
                itemCount: p.items.length,
                itemBuilder: (context, index) => _OnboardingPage(
                  item: p.items[index],
                  accentColor: _pageAccentColors[index],
                ),
              ),
            ),

            // Dots indicator + page counter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      p.items.length,
                      (index) => _Dot(isActive: index == p.currentPage),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${p.currentPage + 1}/${p.items.length}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AppButton(
                title: p.isLastPage ? 'Get Started' : 'Next',
                gradient: p.isLastPage,
                shadow: p.isLastPage,
                backgroundColor: p.isLastPage ? null : AppColors.primary,
                textColor: p.isLastPage ? AppColors.primary : AppColors.white,
                onPressed: p.isLastPage
                    ? () => provider.complete(context)
                    : provider.nextPage,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final Color accentColor;

  const _OnboardingPage({
    required this.item,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Decorative circle with icon
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 52,
                  color: accentColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
