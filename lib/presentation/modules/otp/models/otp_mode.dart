/// Why the OTP screen is open.
enum OtpMode {
  /// Existing account: the code logs the user in.
  login,

  /// Just registered: the code confirms the phone number.
  registration,
}
