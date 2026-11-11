import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';

/// Records the request instead of sending it over the network.
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
      '{}',
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
  late Dio dio;
  late _CapturingAdapter adapter;

  setUpAll(() {
    dio = DioFactory.getDio();
    adapter = _CapturingAdapter();
    dio.httpClientAdapter = adapter;
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
  });

  Future<Map<String, dynamic>> sentHeaders() async {
    await dio.get<dynamic>('https://example.test/ping');
    return adapter.lastRequest!.headers;
  }

  test('headers follow the token in storage through login and logout', () async {
    // Logged out: no Authorization header, default headers kept.
    var headers = await sentHeaders();
    expect(headers.containsKey('Authorization'), isFalse);
    expect(headers['Accept'], 'application/json');
    expect(headers['Accept-Language'], 'en');

    // Logged in: the saved token is sent, other headers are kept.
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, 'abc');
    headers = await sentHeaders();
    expect(headers['Authorization'], 'Bearer abc');
    expect(headers['Accept'], 'application/json');
    expect(headers['Accept-Language'], 'en');

    // Storage cleared (logout / 401): the token stops being sent.
    await SharedPrefHelper.clearAllSecuredData();
    headers = await sentHeaders();
    expect(headers.containsKey('Authorization'), isFalse);
  });

  test('sends a token saved by a previous app run', () async {
    FlutterSecureStorage.setMockInitialValues(<String, String>{
      SharedPrefKeys.userToken: 'from-last-run',
    });

    final headers = await sentHeaders();
    expect(headers['Authorization'], 'Bearer from-last-run');
  });

  test('sends the saved language', () async {
    SharedPreferences.setMockInitialValues({SharedPrefKeys.userLanguage: 'ar'});

    final headers = await sentHeaders();
    expect(headers['Accept-Language'], 'ar');
  });
}
