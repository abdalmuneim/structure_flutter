import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/bases/ui_effect.dart';
import 'package:structure_flutter/presentation/components/extensions/alerts_extension.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  BaseScene — a screen backed by a BaseProvider
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class BaseScene<T extends BaseProvider> extends StatefulWidget {
  const BaseScene({super.key});

  @override
  BaseSceneState<T> createState();
}

abstract class BaseSceneState<T extends BaseProvider>
    extends State<BaseScene<T>>
    with WidgetsBindingObserver {
  // ── Subclass API ──────────────────────────────────────────────

  /// Build the screen UI. Called when the provider calls `notifyListeners()`.
  Widget buildWidget(BuildContext context, T provider);

  /// Handle feature-specific effects. Loading, error, success and
  /// navigation effects are already handled by the base.
  void onEffect(BuildContext context, UiEffect effect) {}

  /// Runs once after the first frame (e.g. initial API call).
  void afterFirstFrame() {}

  // ── Screen info ───────────────────────────────────────────────

  late double screenWidth;
  late double screenHeight;

  bool _isKeyboardOpen = false;
  bool get isKeyboardOpen => _isKeyboardOpen;

  // ── Shortcuts ─────────────────────────────────────────────────

  T get provider => context.read<T>();
  NavigatorState get navigator => Navigator.of(context);
  ThemeData get theme => Theme.of(context);

  // ── Effect subscription ───────────────────────────────────────

  T? _provider;
  StreamSubscription<UiEffect>? _effectSubscription;
  bool _isLoadingDialogOpen = false;

  // ── Lifecycle ─────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstFrame());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newProvider = context.read<T>();
    if (_provider != newProvider) {
      _effectSubscription?.cancel();
      _provider = newProvider;
      _effectSubscription = newProvider.effects.listen(_handleEffect);
    }
  }

  @override
  void dispose() {
    _effectSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardOpen) {
      setState(() => _isKeyboardOpen = newValue);
    }
  }

  // ── Build ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenWidth = constraints.biggest.width;
        screenHeight = constraints.biggest.height;
        return Consumer<T>(
          builder: (context, provider, _) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: buildWidget(context, provider),
            );
          },
        );
      },
    );
  }

  // ── Effects ───────────────────────────────────────────────────

  void _handleEffect(UiEffect effect) {
    if (!mounted) return;

    switch (effect) {
      case ShowLoadingEffect():
        _showLoadingDialog();
      case HideLoadingEffect():
        _hideLoadingDialog();
      case ShowErrorEffect(:final message):
        showError(message);
      case ShowSuccessEffect(:final message):
        showSuccess(message);
      case NavigateEffect():
        _navigate(effect);
    }
  }

  void _navigate(NavigateEffect effect) {
    if (effect.clearStack) {
      navigator.pushNamedAndRemoveUntil(
        effect.route,
        (route) => false,
        arguments: effect.arguments,
      );
    } else {
      navigator.pushNamed(effect.route, arguments: effect.arguments);
    }
  }

  // ── Loading dialog ────────────────────────────────────────────

  void _showLoadingDialog() {
    if (_isLoadingDialogOpen) return;
    _isLoadingDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _hideLoadingDialog() {
    if (!_isLoadingDialogOpen) return;
    _isLoadingDialogOpen = false;
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
