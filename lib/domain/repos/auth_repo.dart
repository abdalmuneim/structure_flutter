import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';

/// What the app can do for authentication, without saying how.
///
/// The flow (same as lawmate):
/// 1. [handshake] with the phone number.
/// 2. Existing account → [login] with the code sent to the phone.
/// 3. New account → [register], then [verifyRegistrationOtp].
///
/// Use cases depend on this interface; the real implementation is
/// `AuthRepoImp` in `data/repos_imp/`, and tests can pass a fake.
///
/// Methods throw on network or server errors. Use cases turn that into an
/// `ApiResult` with `BaseUseCase.networkRequest`.
abstract class AuthRepo {
  /// Returns true when an account already exists for [phone]
  /// (international format, e.g. +201012345678).
  Future<bool> handshake(String phone);

  /// Logs in with the code sent to [phone] and saves the session.
  Future<User> login({required String phone, required String otpCode});

  /// Creates the account and saves its token. The user is not logged in
  /// until [verifyRegistrationOtp] succeeds.
  Future<User> register(RegisterRequest request);

  /// Confirms the code sent after [register] and marks the user as
  /// logged in.
  Future<User> verifyRegistrationOtp(String otpCode);

  /// Sends the code again.
  Future<void> resendOtp();
}
