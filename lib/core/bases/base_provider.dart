import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:structure_flutter/core/bases/ui_effect.dart';
import 'package:structure_flutter/core/localization/api_error_message.dart';
import 'package:structure_flutter/core/networking/api_result.dart';

/// Base class for every screen provider.
///
/// A provider talks to its screen in two ways:
/// - **State**: fields plus `notifyListeners()`. The screen rebuilds.
/// - **Effects**: one-time actions (loading dialog, toast, navigation) sent
///   with the helpers below. `BaseScene` handles them, and there is nothing
///   to reset afterwards.
///
/// Providers never need a `BuildContext`.
class BaseProvider extends ChangeNotifier {
  final StreamController<UiEffect> _effects =
      StreamController<UiEffect>.broadcast();
  bool _isDisposed = false;

  /// Listened to by `BaseScene`.
  Stream<UiEffect> get effects => _effects.stream;

  // ── Effects ───────────────────────────────────────────────────

  @protected
  void sendEffect(UiEffect effect) {
    if (!_effects.isClosed) _effects.add(effect);
  }

  @protected
  void showLoading() => sendEffect(const ShowLoadingEffect());

  @protected
  void hideLoading() => sendEffect(const HideLoadingEffect());

  @protected
  void showError(String message) => sendEffect(ShowErrorEffect(message));

  @protected
  void showSuccess(String message) => sendEffect(ShowSuccessEffect(message));

  @protected
  void navigateTo(
    String route, {
    Object? arguments,
    bool clearStack = false,
  }) {
    sendEffect(
      NavigateEffect(route, arguments: arguments, clearStack: clearStack),
    );
  }

  // ── Use cases ─────────────────────────────────────────────────

  /// Runs [useCase] while the loading dialog is shown.
  ///
  /// On success calls [onSuccess] with the data; on failure shows the error.
  @protected
  Future<void> runUseCase<R>(
    Future<ApiResult<R>> Function() useCase, {
    required FutureOr<void> Function(R data) onSuccess,
  }) async {
    showLoading();
    final ApiResult<R> result;
    try {
      result = await useCase();
    } finally {
      hideLoading();
    }

    switch (result) {
      case Success<R>(:final data):
        await onSuccess(data);
      case Failure<R>(:final errorHandler):
        showError(localizedApiMessage(errorHandler.apiErrorModel.message));
    }
  }

  // ── Lifecycle ─────────────────────────────────────────────────

  /// Safe to call after an async gap: does nothing once disposed.
  @override
  void notifyListeners() {
    if (!_isDisposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _effects.close();
    super.dispose();
  }
}
