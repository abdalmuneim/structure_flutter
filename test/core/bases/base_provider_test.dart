import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/bases/ui_effect.dart';
import 'package:structure_flutter/core/networking/api_error_handler.dart';
import 'package:structure_flutter/core/networking/api_result.dart';

class _TestProvider extends BaseProvider {
  Future<void> run(Future<ApiResult<String>> Function() useCase) {
    return runUseCase(
      useCase,
      onSuccess: (data) => navigateTo('next/$data', clearStack: true),
    );
  }

  void refresh() => notifyListeners();
}

ApiResult<String> _serverError(int statusCode, String message) {
  final options = RequestOptions(path: '/test');
  return ApiResult<String>.failure(
    ErrorHandler.handle(
      DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          data: {'message': message},
        ),
      ),
    ),
  );
}

void main() {
  late _TestProvider provider;
  late List<UiEffect> effects;

  setUp(() {
    provider = _TestProvider();
    effects = [];
    provider.effects.listen(effects.add);
  });

  // Stream events are delivered asynchronously.
  Future<void> flush() => Future<void>.delayed(Duration.zero);

  test('success: shows then hides loading, then navigates', () async {
    await provider.run(() async => ApiResult<String>.success('ok'));
    await flush();

    expect(effects.map((e) => e.runtimeType), [
      ShowLoadingEffect,
      HideLoadingEffect,
      NavigateEffect,
    ]);
    final navigate = effects.last as NavigateEffect;
    expect(navigate.route, 'next/ok');
    expect(navigate.clearStack, isTrue);
  });

  test('failure: shows then hides loading, then the server message', () async {
    await provider.run(() async => _serverError(422, 'Invalid credentials'));
    await flush();

    expect(effects.map((e) => e.runtimeType), [
      ShowLoadingEffect,
      HideLoadingEffect,
      ShowErrorEffect,
    ]);
    expect((effects.last as ShowErrorEffect).message, 'Invalid credentials');
  });

  test('hides loading even when the use case throws', () async {
    await expectLater(
      provider.run(() async => throw StateError('boom')),
      throwsStateError,
    );
    await flush();

    expect(effects.map((e) => e.runtimeType), [
      ShowLoadingEffect,
      HideLoadingEffect,
    ]);
  });

  test('notifyListeners after dispose does nothing', () {
    provider.dispose();

    expect(provider.refresh, returnsNormally);
  });
}
