import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
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
      appBar: AppBar(title: Text(context.l10n.mainTabSettings)),
      body: Column(
        children: [
          const LanguageSettingTile(),
          const Divider(height: 1),
          Expanded(
            child: EmptyStateView(
              icon: Icons.settings_outlined,
              title: context.l10n.settingsEmptyTitle,
              message: context.l10n.settingsEmptyMessage,
            ),
          ),
        ],
      ),
    );
  }
}
