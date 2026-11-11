import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/data/models/api_response.dart';
import 'package:structure_flutter/data/models/handshake.dart';
import 'package:structure_flutter/data/models/login_request.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';
import 'package:structure_flutter/data/remote/auth_api.dart';
import 'package:structure_flutter/data/repos_imp/auth_repo_imp.dart';

/// Records requests and returns fixed responses instead of calling the server.
class _FakeAuthApi implements AuthApi {
  _FakeAuthApi({this.isExist = true});

  final bool isExist;
  HandshakeRequest? lastHandshake;
  LoginRequest? lastLogin;
  RegisterRequest? lastRegister;
  VerifyOtpRequest? lastVerify;

  static const _userWithToken = User(id: 1, accessToken: 'abc');

  @override
  Future<ApiResponse<HandshakeResult>> handshake(HandshakeRequest r) async {
    lastHandshake = r;
    return ApiResponse(data: HandshakeResult(isExist: isExist));
  }

  @override
  Future<ApiResponse<User>> login(LoginRequest r) async {
    lastLogin = r;
    return const ApiResponse(data: _userWithToken);
  }

  @override
  Future<ApiResponse<User>> register(RegisterRequest r) async {
    lastRegister = r;
    return const ApiResponse(data: _userWithToken);
  }

  @override
  Future<ApiResponse<User>> verifyOtp(VerifyOtpRequest r) async {
    lastVerify = r;
    return const ApiResponse(data: User(id: 1)); // no token in the response
  }

  @override
  Future<void> resendOtp() async {}
}

const _registerRequest = RegisterRequest(
  firstName: 'Ahmed',
  lastName: 'Ali',
  email: 'a@b.com',
  phone: '+201012345678',
  birthdate: '1990-01-31',
  gender: 'male',
);

Future<String> _savedToken() async =>
    await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

Future<bool> _isLoggedIn() async =>
    await SharedPrefHelper.getBool(SharedPrefKeys.isLoggedIn);

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
  });

  test('handshake sends the phone and returns whether it exists', () async {
    final api = _FakeAuthApi(isExist: false);

    final exists = await AuthRepoImp(api).handshake('+201012345678');

    expect(api.lastHandshake?.phone, '+201012345678');
    expect(exists, isFalse);
  });

  test('login sends phone, code and language, then saves the session', () async {
    SharedPreferences.setMockInitialValues({SharedPrefKeys.userLanguage: 'ar'});
    final api = _FakeAuthApi();

    await AuthRepoImp(api).login(phone: '+201012345678', otpCode: '1234');

    expect(api.lastLogin?.phone, '+201012345678');
    expect(api.lastLogin?.otpCode, '1234');
    expect(api.lastLogin?.language, 'ar');
    expect(await _savedToken(), 'abc');
    expect(await _isLoggedIn(), isTrue);
  });

  test('register saves the token but does not log in yet', () async {
    final api = _FakeAuthApi();

    await AuthRepoImp(api).register(_registerRequest);

    expect(api.lastRegister?.language, 'en'); // default when none is saved
    expect(api.lastRegister?.phone, '+201012345678');
    expect(await _savedToken(), 'abc');
    expect(await _isLoggedIn(), isFalse);
  });

  test('verifying the registration code logs in and keeps the token', () async {
    final api = _FakeAuthApi();
    final repo = AuthRepoImp(api);
    await repo.register(_registerRequest);

    await repo.verifyRegistrationOtp('5678');

    expect(api.lastVerify?.otpCode, '5678');
    expect(await _isLoggedIn(), isTrue);
    expect(await _savedToken(), 'abc');
  });
}
