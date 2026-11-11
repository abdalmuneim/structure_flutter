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
      ApiErrorsMessage.noContent; // success with no data (no content)
  static const String badRequest =
      ApiErrorsMessage.badRequestError; // failure, API rejected request
  static const String unauthorised =
      ApiErrorsMessage.unauthorizedError; // failure, user is not authorised
  static const String forbidden =
      ApiErrorsMessage.forbiddenError; //  failure, API rejected request
  static const String internalServerError =
      ApiErrorsMessage.internalServerError; // failure, crash in server side
  static const String notFound =
      ApiErrorsMessage.notFoundError; // failure, crash in server side

  // local status code
  static String connectTimeout = ApiErrorsMessage.timeoutError;
  static String cancel = ApiErrorsMessage.defaultError;
  static String recieveTimeout = ApiErrorsMessage.timeoutError;
  static String sendTimeout = ApiErrorsMessage.timeoutError;
  static String cacheError = ApiErrorsMessage.cacheError;
  static String noInternetConnection = ApiErrorsMessage.noInternetError;
  static String defaultError = ApiErrorsMessage.defaultError;
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
    try {
      apiErrorModel = error is DioException
          // dio error so its an error from response of the API or from dio itself
          ? _handleError(error)
          : DataSource.defaultError.getFailure();
    } catch (_) {
      // Building the error must never throw: callers rely on getting a
      // Failure back so they can turn their loading state off.
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
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      return _fromResponse(error.response);
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();
  }
}

/// Builds the error for a failed HTTP response.
///
/// [ApiErrorModel.code] is the HTTP status code, so checks such as 401 work
/// even when the body has no `code` field. The server's `message` is used
/// when the body is a JSON object that has one; for anything else (HTML error
/// pages, plain text, empty body) a generic message for the status is used.
ApiErrorModel _fromResponse(Response? response) {
  final statusCode = response?.statusCode;
  final fallback = _dataSourceForStatus(statusCode).getFailure();

  final body = response?.data;
  final bodyMessage = body is Map ? body['message'] : null;
  final bodyCode = body is Map ? body['code'] : null;

  return ApiErrorModel(
    message: bodyMessage is String && bodyMessage.isNotEmpty
        ? bodyMessage
        : fallback.message,
    code: statusCode ?? (bodyCode is int ? bodyCode : fallback.code),
  );
}

DataSource _dataSourceForStatus(int? statusCode) => switch (statusCode) {
  ResponseCode.badRequest => DataSource.badRequest,
  ResponseCode.unauthorised => DataSource.unauthorised,
  ResponseCode.forbidden => DataSource.forbidden,
  ResponseCode.notFound => DataSource.notFound,
  ResponseCode.internalServerError => DataSource.internalServerError,
  _ => DataSource.defaultError,
};

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
