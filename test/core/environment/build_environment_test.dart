import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/environment/build_environment.dart';
import 'package:structure_flutter/core/environment/development_keys.dart';
import 'package:structure_flutter/core/environment/production_keys.dart';
import 'package:structure_flutter/core/networking/apis_constant.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';
import 'package:structure_flutter/data/models/handshake.dart';
import 'package:structure_flutter/data/remote/auth_api.dart';

/// Records the request and answers like the handshake endpoint.
class _CapturingAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      '{"data":{"is_exist":true}}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('flavor comes from --dart-define=FLAVOR (development by default)', () {
    const define = String.fromEnvironment(
      'FLAVOR',
      defaultValue: 'development',
    );

    expect(BuildEnvironment.flavor.name, define);
    expect(BuildEnvironment.keys.apiUrl, isNotEmpty);
  });

  test('development and production have an API URL ending with /', () {
    for (final apiUrl in [DevelopmentKeys().apiUrl, ProductionKeys().apiUrl]) {
      expect(apiUrl, startsWith('https://'));
      expect(apiUrl, endsWith('/'));
    }
  });

  test('API requests go to the environment API URL + endpoint', () async {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
    final dio = DioFactory.getDio();
    final adapter = _CapturingAdapter();
    dio.httpClientAdapter = adapter;

    final response = await AuthApi(
      dio,
    ).handshake(const HandshakeRequest(phone: '+201012345678'));

    expect(
      adapter.lastRequest!.uri.toString(),
      '${BuildEnvironment.keys.apiUrl}${ApiConstants.handshake}',
    );
    expect(response.data.isExist, isTrue);
  });
}
