import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/data/models/handshake.dart';
import 'package:structure_flutter/data/models/login_request.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';
import 'package:structure_flutter/data/remote/auth_api.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  AuthRepoImp(this._api);

  final AuthApi _api;

  @override
  Future<bool> handshake(String phone) async {
    final response = await _api.handshake(HandshakeRequest(phone: phone));
    return response.data.isExist;
  }

  @override
  Future<User> login({required String phone, required String otpCode}) async {
    final response = await _api.login(
      LoginRequest(phone: phone, otpCode: otpCode, language: await _language()),
    );
    final user = response.data;
    await _saveToken(user.accessToken);
    await _setLoggedIn(true);
    return user;
  }

  @override
  Future<User> register(RegisterRequest request) async {
    final response = await _api.register(
      request.withLanguage(await _language()),
    );
    // The token is needed to call verify-otp, but the user only counts as
    // logged in once the code is confirmed.
    await _saveToken(response.data.accessToken);
    return response.data;
  }

  @override
  Future<User> verifyRegistrationOtp(String otpCode) async {
    final response = await _api.verifyOtp(VerifyOtpRequest(otpCode: otpCode));
    await _saveToken(response.data.accessToken);
    await _setLoggedIn(true);
    return response.data;
  }

  @override
  Future<void> resendOtp() => _api.resendOtp();

  // ── Session storage ───────────────────────────────────────────

  /// The Dio interceptor reads the token from storage on every request,
  /// so saving it here is all that is needed for later requests to send it.
  Future<void> _saveToken(String? token) async {
    if (token == null || token.isEmpty) return;
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
  }

  /// Splash opens the main screen only when this is true.
  Future<void> _setLoggedIn(bool value) =>
      SharedPrefHelper.setData(SharedPrefKeys.isLoggedIn, value);

  Future<String> _language() async {
    final String language = await SharedPrefHelper.getString(
      SharedPrefKeys.userLanguage,
    );
    return language.isEmpty ? 'en' : language;
  }
}
