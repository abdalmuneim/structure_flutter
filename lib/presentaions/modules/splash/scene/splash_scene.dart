import 'package:flutter/material.dart';

class SplashScene extends StatefulWidget {
  const SplashScene({super.key});

  @override
  State<SplashScene> createState() => _SplashSceneState();
}

class _SplashSceneState extends State<SplashScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Container(),
    );
  }
}
