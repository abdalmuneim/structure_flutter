import 'package:structure_flutter/core/networking/api_error_handler.dart';
import 'package:structure_flutter/core/networking/api_result.dart';

abstract class BaseUseCase<Params, Result> {
  Future<ApiResult<Result>> call(Params params);

  /// Wraps any API call with try/catch and returns [ApiResult].
  /// Use this inside [call] to avoid repeating error handling.
  Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}

class NoParams {
  const NoParams();
}
