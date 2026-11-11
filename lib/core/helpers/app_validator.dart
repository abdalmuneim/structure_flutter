class AppValidator {
  AppValidator._();

  // ──────────────────────────── Required ────────────────────────────

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // ──────────────────────────── Email ────────────────────────────

  static final _emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  // ──────────────────────────── Password ────────────────────────────

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final error = AppValidator.password(value);
    if (error != null) return error;
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static final _strongPasswordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$');

  static String? strongPassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    if (!_strongPasswordRegex.hasMatch(value)) {
      return 'Must include uppercase, lowercase, number, and special character';
    }
    return null;
  }

  // ──────────────────────────── Phone ────────────────────────────

  static final _phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (!_phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // ──────────────────────────── Username ────────────────────────────

  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9._]{3,30}$');

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    if (!_usernameRegex.hasMatch(value.trim())) {
      return 'Username must be 3-30 chars (letters, numbers, . or _)';
    }
    return null;
  }

  // ──────────────────────────── Egyptian mobile ────────────────────────────

  static final _egyptianPhoneRegex = RegExp(r'^01[0125][0-9]{8}$');

  /// 11 digits starting with 010, 011, 012 or 015 (same rule as lawmate).
  static String? egyptianPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone field is required';
    }
    if (!_egyptianPhoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // ──────────────────────────── Name ────────────────────────────

  static final _lettersOnlyRegex = RegExp(r'^[a-zA-Z؀-ۿ]+$');

  /// 3–30 English or Arabic letters, no spaces (same rule as lawmate).
  static String? name(String? value, [String fieldName = 'Name']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    final trimmed = value.trim();
    if (trimmed.length < 3 || trimmed.length > 30) {
      return '$fieldName must be between 3 and 30 characters';
    }
    if (!_lettersOnlyRegex.hasMatch(trimmed)) {
      return '$fieldName must contain letters only';
    }
    return null;
  }

  // ──────────────────────────── Birthdate ────────────────────────────

  static final _dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  /// A real yyyy-MM-dd date in the past, at least [minimumAge] years ago.
  static String? birthdate(String? value, {int minimumAge = 20}) {
    if (value == null || value.trim().isEmpty) {
      return 'Date of birth is required';
    }
    final trimmed = value.trim();
    if (!_dateRegex.hasMatch(trimmed)) {
      return 'Please enter a valid date of birth';
    }
    final parts = trimmed.split('-').map(int.parse).toList();
    final date = DateTime(parts[0], parts[1], parts[2]);
    // DateTime rolls invalid dates over (e.g. Feb 30 → Mar 2).
    if (parts[0] < 1900 || date.month != parts[1] || date.day != parts[2]) {
      return 'Please enter a valid date of birth';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (!date.isBefore(today)) {
      return 'Date of birth can’t be today or in the future';
    }
    if (date.isAfter(DateTime(today.year - minimumAge, today.month, today.day))) {
      return 'You must be at least $minimumAge years old';
    }
    return null;
  }

  // ──────────────────────────── URL ────────────────────────────

  static final _urlRegex = RegExp(
    r'^https?:\/\/([\w\-]+(\.[\w\-]+)+)(\/[\w\-._~:/?#\[\]@!$&()*+,;=%]*)?$',
  );

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) return 'URL is required';
    if (!_urlRegex.hasMatch(value.trim())) return 'Enter a valid URL';
    return null;
  }

  // ──────────────────────────── Number ────────────────────────────

  static String? numeric(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (double.tryParse(value.trim()) == null) {
      return '$fieldName must be a number';
    }
    return null;
  }

  static String? numericRange(
    String? value, {
    required double min,
    required double max,
    String fieldName = 'Value',
  }) {
    final error = numeric(value, fieldName);
    if (error != null) return error;
    final number = double.parse(value!.trim());
    if (number < min || number > max) {
      return '$fieldName must be between $min and $max';
    }
    return null;
  }

  // ──────────────────────────── Length ────────────────────────────

  static String? minLength(
    String? value, int min, [String fieldName = 'This field',
  ]) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (value.trim().length < min) {
      return '$fieldName must be at least $min characters';
    }
    return null;
  }

  static String? maxLength(
    String? value, int max, [String fieldName = 'This field',
  ]) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (value.trim().length > max) {
      return '$fieldName must be at most $max characters';
    }
    return null;
  }

  // ──────────────────────────── OTP / PIN ────────────────────────────

  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) return 'OTP is required';
    if (value.trim().length != length || int.tryParse(value.trim()) == null) {
      return 'OTP must be $length digits';
    }
    return null;
  }

  // ──────────────────────────── Credit Card ────────────────────────────

  static final _cardRegex = RegExp(r'^\d{13,19}$');

  static String? creditCard(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required';
    }
    final digits = value.replaceAll(RegExp(r'\s|-'), '');
    if (!_cardRegex.hasMatch(digits)) return 'Enter a valid card number';
    return null;
  }

  // ──────────────────────────── National ID ────────────────────────────

  static String? nationalId(String? value, {int length = 14}) {
    if (value == null || value.trim().isEmpty) {
      return 'National ID is required';
    }
    final trimmed = value.trim();
    if (trimmed.length != length || int.tryParse(trimmed) == null) {
      return 'National ID must be $length digits';
    }
    return null;
  }

  // ──────────────────────────── Compose ────────────────────────────

  /// Runs multiple validators in order; returns the first error or null.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
