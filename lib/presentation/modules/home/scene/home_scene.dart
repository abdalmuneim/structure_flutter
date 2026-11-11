import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/presentation/components/widgets/empty_state_view.dart';
import 'package:structure_flutter/presentation/modules/home/providers/home_provider.dart';

class HomeScene extends BaseScene<HomeProvider> {
  const HomeScene({super.key});

  @override
  BaseSceneState<HomeProvider> createState() => _HomeSceneState();
}

class _HomeSceneState extends BaseSceneState<HomeProvider> {
  @override
  Widget buildWidget(BuildContext context, HomeProvider p) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const EmptyStateView(
        icon: Icons.local_hospital,
        title: 'Your home feed',
        message: 'Content for the home screen will appear here.',
      ),
    );
  }
}
