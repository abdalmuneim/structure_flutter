import 'package:flutter/material.dart';
import 'package:structure_flutter/core/networking/api_error_model.dart';

/// Provider for scenes that have **no** form model (e.g. Splash, Settings).
class BaseProvider<D extends Object?> extends ChangeNotifier {
  bool _isLoading = false;
  ApiErrorModel? _error;
  String? _errorMessage;
  String? _successMessage;
  bool _isDisposed = false;

  D? model;

  bool get isLoading => _isLoading;
  ApiErrorModel? get error => _error;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  bool get hasError => _error != null || _errorMessage != null;
  bool get hasSuccess => _successMessage != null;

  void setLoading(bool value) {
    _isLoading = value;
    _safeNotifyListeners();
  }

  void setError(ApiErrorModel? error) {
    _error = error;
    _errorMessage = error?.message;
    _safeNotifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;

    _safeNotifyListeners();
  }

  void setSuccess(String message) {
    _successMessage = message;
    _safeNotifyListeners();
  }

  void clearError() {
    _error = null;
    _errorMessage = null;
    _safeNotifyListeners();
  }

  void clearSuccess() {
    _successMessage = null;
    _safeNotifyListeners();
  }

  void _safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
