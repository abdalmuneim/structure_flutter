import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/core/networking/api_error_handler.dart';

DioException _badResponse(int statusCode, dynamic body) {
  final options = RequestOptions(path: '/test');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: statusCode,
      data: body,
    ),
  );
}

void main() {
  group('ErrorHandler.handle', () {
    test('uses the HTTP status as code when the JSON body has none', () {
      final model = ErrorHandler.handle(
        _badResponse(401, {'message': 'Unauthenticated.'}),
      ).apiErrorModel;

      expect(model.code, ResponseCode.unauthorised);
      expect(model.message, 'Unauthenticated.');
    });

    test('does not throw for an HTML error page', () {
      final model = ErrorHandler.handle(
        _badResponse(502, '<html><body>Bad Gateway</body></html>'),
      ).apiErrorModel;

      expect(model.code, 502);
      expect(model.message, ResponseMessage.defaultError);
    });

    test('does not throw when the body message is not a string', () {
      final model = ErrorHandler.handle(
        _badResponse(422, {
          'message': ['The email field is required.'],
        }),
      ).apiErrorModel;

      expect(model.code, 422);
      expect(model.message, ResponseMessage.defaultError);
    });

    test('uses the generic message for a known status with an empty body', () {
      final model = ErrorHandler.handle(_badResponse(404, null)).apiErrorModel;

      expect(model.code, ResponseCode.notFound);
      expect(model.message, ResponseMessage.notFound);
    });

    test('maps connection errors to no internet', () {
      final model = ErrorHandler.handle(
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/test'),
          reason: 'Connection refused',
        ),
      ).apiErrorModel;

      expect(model.code, ResponseCode.noInternetConnection);
    });

    test('maps non-Dio errors to the default error', () {
      final model = ErrorHandler.handle(StateError('boom')).apiErrorModel;

      expect(model.code, ResponseCode.defaultError);
    });
  });
}
