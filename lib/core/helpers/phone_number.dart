class PhoneNumber {
  PhoneNumber._();

  /// Converts an Egyptian mobile number as the user types it
  /// (01012345678) to the format the API expects (+201012345678).
  static String egyptianInternational(String localNumber) {
    final digits = localNumber.trim();
    return '+20${digits.startsWith('0') ? digits.substring(1) : digits}';
  }
}
