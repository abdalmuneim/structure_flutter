import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/presentaions/components/extensions/alerts_extension.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  BaseScene — for scenes WITHOUT a form model
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class BaseScene<T extends BaseProvider, D> extends StatefulWidget {
  const BaseScene({super.key});

  @override
  BaseSceneState<T, D> createState();
}

abstract class BaseSceneState<T extends BaseProvider, D>
    extends State<BaseScene<T, D>>
    with WidgetsBindingObserver {
  // ── Subclass API ──────────────────────────────────────────────

  /// Build the screen UI. Called only on render-data changes.
  Widget buildWidget(BuildContext context, T provider);

  /// Handle custom non-render side-effects that the base doesn't cover.
  /// Loading / error / success are already handled automatically.
  void listenToState(BuildContext context, T provider) {}

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

  // ── Non-render state tracking ─────────────────────────────────

  T? _provider;
  bool _wasLoading = false;
  bool _hadError = false;
  bool _hadSuccess = false;
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
      _provider?.removeListener(_onProviderChanged);
      _provider = newProvider;
      _provider!.addListener(_onProviderChanged);
    }
  }

  @override
  void dispose() {
    _provider?.removeListener(_onProviderChanged);
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

  // ── Non-render listener ───────────────────────────────────────

  void _onProviderChanged() {
    final p = _provider;
    if (p == null || !mounted) return;

    // Loading
    if (p.isLoading && !_wasLoading) {
      _showLoadingDialog();
    } else if (!p.isLoading && _wasLoading) {
      _hideLoadingDialog();
    }
    _wasLoading = p.isLoading;

    // Error
    if (p.hasError && !_hadError) {
      showError(p.errorMessage ?? 'An error occurred');
      p.clearError();
    }
    _hadError = p.hasError;

    // Success
    if (p.hasSuccess && !_hadSuccess) {
      showSuccess(p.successMessage!);
      p.clearSuccess();
    }
    _hadSuccess = p.hasSuccess;

    // Custom
    listenToState(context, p);
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
