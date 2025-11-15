import 'dart:convert';

import 'package:dio/dio.dart';

import 'apis_constant.dart';
import 'api_error_model.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found
  static const int apiLogicError = 422; // API , lOGIC ERROR

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int recieveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const String noContent =
      ApiErrors.noContent; // success with no data (no content)
  static const String badRequest =
      ApiErrors.badRequestError; // failure, API rejected request
  static const String unauthorised =
      ApiErrors.unauthorizedError; // failure, user is not authorised
  static const String forbidden =
      ApiErrors.forbiddenError; //  failure, API rejected request
  static const String internalServerError =
      ApiErrors.internalServerError; // failure, crash in server side
  static const String notFound =
      ApiErrors.notFoundError; // failure, crash in server side

  // local status code
  static String connectTimeout = ApiErrors.timeoutError;
  static String cancel = ApiErrors.defaultError;
  static String recieveTimeout = ApiErrors.timeoutError;
  static String sendTimeout = ApiErrors.timeoutError;
  static String cacheError = ApiErrors.cacheError;
  static String noInternetConnection = ApiErrors.noInternetError;
  static String defaultError = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.noContent:
        return ApiErrorModel(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return ApiErrorModel(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return ApiErrorModel(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case DataSource.unauthorised:
        return ApiErrorModel(
          code: ResponseCode.unauthorised,
          message: ResponseMessage.unauthorised,
        );
      case DataSource.notFound:
        return ApiErrorModel(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return ApiErrorModel(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return ApiErrorModel(
          code: ResponseCode.connectTimeout,
          message: ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return ApiErrorModel(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case DataSource.recieveTimeout:
        return ApiErrorModel(
          code: ResponseCode.recieveTimeout,
          message: ResponseMessage.recieveTimeout,
        );
      case DataSource.sendTimeout:
        return ApiErrorModel(
          code: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return ApiErrorModel(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return ApiErrorModel(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case DataSource.defaultError:
        return ApiErrorModel(
          code: ResponseCode.defaultError,
          message: ResponseMessage.defaultError,
        );
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      apiErrorModel = _handleError(error);
    } else {
      // default error
      apiErrorModel = DataSource.defaultError.getFailure();
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.recieveTimeout.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      // Could be DNS/host lookup or no network
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();

    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      // Try to parse API error body when available and it's a JSON map
      final resp = error.response;
      if (resp != null && resp.data != null) {
        try {
          if (resp.data is Map<String, dynamic>) {
            return ApiErrorModel.fromJson(resp.data as Map<String, dynamic>);
          }
          // If data is a JSON string, try decoding it
          if (resp.data is String) {
            try {
              final decoded = resp.data as String;
              final dynamic jsonObj = decoded.isNotEmpty
                  ? jsonDecode(decoded)
                  : null;
              if (jsonObj is Map<String, dynamic>) {
                return ApiErrorModel.fromJson(jsonObj);
              }
            } catch (_) {
              // fallthrough to status code mapping
            }
          }
        } catch (_) {
          // parsing failed, fallthrough to status code mapping
        }

        // Fallback: map common HTTP status codes to DataSource
        final status = resp.statusCode;
        switch (status) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.unauthorised:
            return DataSource.unauthorised.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          case ResponseCode.noContent:
            return DataSource.noContent.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }
      }

      return DataSource.defaultError.getFailure();
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
