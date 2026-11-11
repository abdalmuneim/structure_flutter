import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/networking/api_error_handler.dart';
import 'package:structure_flutter/core/networking/api_result.dart';

/// Runs whatever request it is given through [BaseUseCase.networkRequest].
class _TestUseCase extends BaseUseCase<Future<String> Function(), String> {
  _TestUseCase({this.handleError});

  final Function(ErrorHandler handler)? handleError;

  @override
  Future<ApiResult<String>> call(Future<String> Function() params) =>
      networkRequest(params, handleError: handleError);
}

Future<String> _failWith(int statusCode, dynamic body) async {
  final options = RequestOptions(path: '/test');
  throw DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: statusCode,
      data: body,
    ),
  );
}

int? _failureCode(ApiResult<String> result) => switch (result) {
  Failure<String>(:final errorHandler) => errorHandler.apiErrorModel.code,
  _ => null,
};

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues(<String, String>{
      SharedPrefKeys.userToken: 'abc',
    });
  });

  test('returns Success with the response data', () async {
    final result = await _TestUseCase().call(() async => 'ok');

    expect(result, isA<Success<String>>());
  });

  test('401 with an HTML body returns Failure and clears the token', () async {
    final result = await _TestUseCase().call(
      () => _failWith(401, '<html>Unauthorized</html>'),
    );

    expect(result, isA<Failure<String>>());
    expect(_failureCode(result), ResponseCode.unauthorised);
    expect(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
      isEmpty,
    );
  });

  test('a throwing handleError callback still returns Failure', () async {
    final useCase = _TestUseCase(
      handleError: (_) => throw StateError('callback failed'),
    );

    final result = await useCase.call(() => _failWith(500, null));

    expect(result, isA<Failure<String>>());
    expect(_failureCode(result), ResponseCode.internalServerError);
  });
}
