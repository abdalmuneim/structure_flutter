import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/presentation/modules/main/models/main_tab.dart';

/// Which tab of the main screen is selected.
///
/// Each tab has its own provider (HomeProvider, NotificationsProvider…)
/// for its own state; this one only handles switching.
class MainProvider extends BaseProvider {
  MainProvider({MainTab initialTab = MainTab.home}) : _currentTab = initialTab;

  MainTab _currentTab;
  MainTab get currentTab => _currentTab;

  void selectTab(MainTab tab) {
    if (tab == _currentTab) return;
    _currentTab = tab;
    notifyListeners();
  }
}
