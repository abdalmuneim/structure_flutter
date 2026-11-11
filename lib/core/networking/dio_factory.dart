import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:structure_flutter/core/environment/build_environment.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() => _dio ??= _createDio();

  static Dio _createDio() {
    const timeOut = Duration(seconds: 30);

    final dio = Dio(
      BaseOptions(
        baseUrl: BuildEnvironment.keys.apiUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(_AuthHeadersInterceptor());

    // Logs request bodies (passwords) and headers (Bearer token),
    // so it must never run in release builds.
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}

/// Adds `Authorization` and `Accept-Language` to every request, read from
/// storage at send time.
///
/// Because nothing is copied into the Dio instance, the headers always match
/// what is saved: a token saved at login or kept from a previous app run is
/// sent, and a token cleared on logout / 401 stops being sent.
class _AuthHeadersInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final String token = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      );
      final String language = await SharedPrefHelper.getString(
        SharedPrefKeys.userLanguage,
      );

      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      options.headers['Accept-Language'] = language.isEmpty ? 'en' : language;

      handler.next(options);
    } catch (error, stackTrace) {
      // The handler must always be called, otherwise the request hangs.
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
