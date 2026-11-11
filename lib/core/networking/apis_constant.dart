/// Endpoint paths, relative to the environment's API URL
/// (`BuildEnvironment.keys.apiUrl`, set on Dio in `DioFactory`).
class ApiConstants {
  // ── Authentication ──────────────────────────────────────────────
  /// Body: {phone}. Response data: {is_exist}.
  static const String handshake = "authentication/login/handshake";

  /// Body: {phone, otp_code, language}. Response data: user + access_token.
  static const String login = "authentication/login";

  /// Body: {first_name, last_name, email, phone, birthdate, gender, language}.
  static const String register = "authentication/register";

  /// Confirms the code sent after register. Body: {otp_code}. Needs the token.
  static const String verifyOtp = "authentication/verify-otp";

  static const String resendOtp = "authentication/resend-otp";
}

class ApiErrorsMessage {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
