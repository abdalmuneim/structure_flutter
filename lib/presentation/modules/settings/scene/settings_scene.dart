import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/presentation/components/widgets/empty_state_view.dart';
import 'package:structure_flutter/presentation/components/widgets/language_switcher.dart';
import 'package:structure_flutter/presentation/modules/settings/providers/settings_provider.dart';

class SettingsScene extends BaseScene<SettingsProvider> {
  const SettingsScene({super.key});

  @override
  BaseSceneState<SettingsProvider> createState() => _SettingsSceneState();
}

class _SettingsSceneState extends BaseSceneState<SettingsProvider> {
  @override
  Widget buildWidget(BuildContext context, SettingsProvider p) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Column(
        children: [
          LanguageSettingTile(),
          Divider(height: 1),
          Expanded(
            child: EmptyStateView(
              icon: Icons.settings_outlined,
              title: 'App settings',
              message: 'Settings options will appear here.',
            ),
          ),
        ],
      ),
    );
  }
}
