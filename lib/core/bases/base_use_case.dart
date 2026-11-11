import 'package:flutter/material.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/networking/api_error_handler.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/core/routing/route_path.dart';

abstract class BaseUseCase<Params, Result> {
  Future<ApiResult<Result>> call(Params params);

  /// Global navigator key — set this from your MaterialApp.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Wraps any API request with error handling and response mapping.
  ///
  /// Uses [ErrorHandler] which already maps every [DioExceptionType]
  /// to the correct [ApiErrorModel] with proper [ResponseCode] and
  /// [ResponseMessage]. For badResponse / unknown it parses the server
  /// JSON via [ApiErrorModel.fromJson].
  ///
  /// After building the [ErrorHandler], checks [ApiErrorModel.code]:
  /// - 401 → clears storage and navigates to login.
  ///
  /// [request] - the API future to execute.
  /// [handleError] - optional custom error callback; if provided,
  ///   the default 401 handling is skipped.
  Future<ApiResult<T>> networkRequest<T>(
    Future<T> Function() request, {
    Function(ErrorHandler handler)? handleError,
  }) async {
    try {
      final response = await request();
      return ApiResult.success(response);
    } catch (error) {
      final handler = ErrorHandler.handle(error);

      try {
        if (handleError != null) {
          handleError(handler);
        } else {
          await _handleByCode(handler);
        }
      } catch (sideEffectError) {
        // A failing side effect (custom callback, clearing storage on 401)
        // must not stop us from returning a Failure, or the caller never
        // gets to turn its loading state off.
        debugPrint('networkRequest: error handling failed: $sideEffectError');
      }

      return ApiResult.failure(handler);
    }
  }

  /// Checks [ApiErrorModel.code] from [ErrorHandler] for global actions.
  ///
  /// - [ResponseCode.unauthorised] (401) → clears all user data and
  ///   navigates to login using [navigatorKey].
  Future<void> _handleByCode(ErrorHandler handler) async {
    final code = handler.apiErrorModel.code;

    if (code == ResponseCode.unauthorised) {
      await _handleUnauthorized();
    }
  }

  Future<void> _handleUnauthorized() async {
    // The app language is a device setting, not session data: keep it, or
    // the API (Accept-Language) would switch to English after a 401.
    final String language = await SharedPrefHelper.getString(
      SharedPrefKeys.userLanguage,
    );
    await SharedPrefHelper.clearAllData();
    await SharedPrefHelper.clearAllSecuredData();
    if (language.isNotEmpty) {
      await SharedPrefHelper.setData(SharedPrefKeys.userLanguage, language);
    }
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      RoutePath.login,
      (route) => false,
    );
  }
}

class NoParams {
  const NoParams();
}
