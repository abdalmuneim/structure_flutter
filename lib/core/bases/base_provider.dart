import 'package:flutter/material.dart';
import 'package:structure_flutter/core/networking/api_error_handler.dart';
import 'package:structure_flutter/core/networking/api_error_model.dart';
import 'package:structure_flutter/core/networking/api_result.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  ApiErrorModel? _error;
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  ApiErrorModel? get error => _error;
  bool get hasError => _error != null;

  void setLoading(bool value) {
    _isLoading = value;
    _safeNotifyListeners();
  }

  void setError(ApiErrorModel? error) {
    _error = error;
    _safeNotifyListeners();
  }

  void clearError() {
    _error = null;
    _safeNotifyListeners();
  }

  /// Executes an API call with automatic loading and error handling.
  ///
  /// [apiCall] - the future that returns an [ApiResult].
  /// [onSuccess] - callback when the API call succeeds.
  /// [onError] - optional callback for custom error handling.
  Future<void> executeApi<T>({
    required Future<ApiResult<T>> Function() apiCall,
    required Function(T data) onSuccess,
    Function(ApiErrorModel error)? onError,
  }) async {
    setLoading(true);
    clearError();
    try {
      final result = await apiCall();
      result.when(
        success: (data) {
          onSuccess(data);
        },
        failure: (errorHandler) {
          setError(errorHandler.apiErrorModel);
          onError?.call(errorHandler.apiErrorModel);
        },
      );
    } catch (e) {
      final handler = ErrorHandler.handle(e);
      setError(handler.apiErrorModel);
      onError?.call(handler.apiErrorModel);
    } finally {
      setLoading(false);
    }
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
