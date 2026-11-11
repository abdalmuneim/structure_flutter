import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/presentation/components/widgets/empty_state_view.dart';
import 'package:structure_flutter/presentation/modules/profile/providers/profile_provider.dart';

class ProfileScene extends BaseScene<ProfileProvider> {
  const ProfileScene({super.key});

  @override
  BaseSceneState<ProfileProvider> createState() => _ProfileSceneState();
}

class _ProfileSceneState extends BaseSceneState<ProfileProvider> {
  @override
  Widget buildWidget(BuildContext context, ProfileProvider p) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const EmptyStateView(
        icon: Icons.person_outline,
        title: 'Your profile',
        message: 'Your account details will appear here.',
      ),
    );
  }
}
