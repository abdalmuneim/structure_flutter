import 'package:dio/dio.dart';
import 'package:structure_flutter/core/helpers/constants.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    final language = await SharedPrefHelper.getString(
      SharedPrefKeys.userLanguage,
    );
    if (token == null || token.isEmpty) {
      dio?.options.headers = {
        'Accept': 'application/json',
        'Accept-Language': language ?? 'en',
      };
      return;
    }
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept-Language': language ?? 'en',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      LogInterceptor(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
