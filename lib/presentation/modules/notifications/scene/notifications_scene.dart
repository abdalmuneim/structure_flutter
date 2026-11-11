import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
import 'package:structure_flutter/presentation/components/widgets/empty_state_view.dart';
import 'package:structure_flutter/presentation/modules/notifications/providers/notifications_provider.dart';

class NotificationsScene extends BaseScene<NotificationsProvider> {
  const NotificationsScene({super.key});

  @override
  BaseSceneState<NotificationsProvider> createState() =>
      _NotificationsSceneState();
}

class _NotificationsSceneState extends BaseSceneState<NotificationsProvider> {
  @override
  Widget buildWidget(BuildContext context, NotificationsProvider p) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.mainTabNotifications)),
      body: EmptyStateView(
        icon: Icons.notifications_none,
        title: context.l10n.notificationsEmptyTitle,
        message: context.l10n.notificationsEmptyMessage,
      ),
    );
  }
}
