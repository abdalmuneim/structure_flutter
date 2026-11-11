import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
import 'package:structure_flutter/presentation/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentation/modules/home/scene/home_scene.dart';
import 'package:structure_flutter/presentation/modules/main/models/main_tab.dart';
import 'package:structure_flutter/presentation/modules/main/providers/main_provider.dart';
import 'package:structure_flutter/presentation/modules/notifications/scene/notifications_scene.dart';
import 'package:structure_flutter/presentation/modules/profile/scene/profile_scene.dart';
import 'package:structure_flutter/presentation/modules/settings/scene/settings_scene.dart';

class MainScene extends BaseScene<MainProvider> {
  const MainScene({super.key});

  @override
  BaseSceneState<MainProvider> createState() => _MainSceneState();
}

class _MainSceneState extends BaseSceneState<MainProvider> {
  @override
  Widget buildWidget(BuildContext context, MainProvider p) {
    return Scaffold(
      // IndexedStack builds every tab once and keeps it alive, so a tab
      // keeps its scroll position and state when the user switches away.
      body: IndexedStack(
        index: p.currentTab.index,
        children: MainTab.values.map(_sceneFor).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: p.currentTab.index,
        onTap: (index) => p.selectTab(MainTab.values[index]),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.greyDark,
        items: MainTab.values.map(_itemFor).toList(),
      ),
    );
  }

  // Both switches are exhaustive: adding a value to MainTab won't compile
  // until it has a scene and a bottom-bar item.

  Widget _sceneFor(MainTab tab) => switch (tab) {
    MainTab.home => const HomeScene(),
    MainTab.notifications => const NotificationsScene(),
    MainTab.profile => const ProfileScene(),
    MainTab.settings => const SettingsScene(),
  };

  BottomNavigationBarItem _itemFor(MainTab tab) => switch (tab) {
    MainTab.home => BottomNavigationBarItem(
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: context.l10n.mainTabHome,
    ),
    MainTab.notifications => BottomNavigationBarItem(
      icon: const Icon(Icons.notifications_outlined),
      activeIcon: const Icon(Icons.notifications),
      label: context.l10n.mainTabNotifications,
    ),
    MainTab.profile => BottomNavigationBarItem(
      icon: const Icon(Icons.person_outline),
      activeIcon: const Icon(Icons.person),
      label: context.l10n.mainTabProfile,
    ),
    MainTab.settings => BottomNavigationBarItem(
      icon: const Icon(Icons.settings_outlined),
      activeIcon: const Icon(Icons.settings),
      label: context.l10n.mainTabSettings,
    ),
  };
}
