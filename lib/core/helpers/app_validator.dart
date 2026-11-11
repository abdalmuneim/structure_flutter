import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';

/// Form validators. Messages are in the current app language
/// ([AppL10n.current]); a `fieldName` passed in should already be translated
/// (e.g. `context.l10n.registerFirstNameField`).
class AppValidator {
  AppValidator._();

  static AppLocalizations get _l10n => AppL10n.current;

  // ──────────────────────────── Required ────────────────────────────

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return _requiredMessage(fieldName);
    }
    return null;
  }

  // ──────────────────────────── Email ────────────────────────────

  static final _emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationEmailRequired;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return _l10n.validationEmailInvalid;
    }
    return null;
  }

  // ──────────────────────────── Password ────────────────────────────

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return _l10n.validationPasswordRequired;
    }
    if (value.length < minLength) {
      return _l10n.validationPasswordMinLength(minLength);
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final error = AppValidator.password(value);
    if (error != null) return error;
    if (value != password) return _l10n.validationPasswordsMismatch;
    return null;
  }

  static final _strongPasswordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$');

  static String? strongPassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return _l10n.validationPasswordRequired;
    }
    if (value.length < minLength) {
      return _l10n.validationPasswordMinLength(minLength);
    }
    if (!_strongPasswordRegex.hasMatch(value)) {
      return _l10n.validationPasswordWeak;
    }
    return null;
  }

  // ──────────────────────────── Phone ────────────────────────────

  static final _phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationPhoneRequired;
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return _l10n.validationPhoneInvalid;
    }
    return null;
  }

  // ──────────────────────────── Username ────────────────────────────

  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9._]{3,30}$');

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationUsernameRequired;
    }
    if (!_usernameRegex.hasMatch(value.trim())) {
      return _l10n.validationUsernameInvalid;
    }
    return null;
  }

  // ──────────────────────────── Egyptian mobile ────────────────────────────

  static final _egyptianPhoneRegex = RegExp(r'^01[0125][0-9]{8}$');

  /// 11 digits starting with 010, 011, 012 or 015 (same rule as lawmate).
  static String? egyptianPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationPhoneRequired;
    }
    if (!_egyptianPhoneRegex.hasMatch(value.trim())) {
      return _l10n.validationPhoneInvalid;
    }
    return null;
  }

  // ──────────────────────────── Name ────────────────────────────

  static final _lettersOnlyRegex = RegExp(r'^[a-zA-Z؀-ۿ]+$');

  /// 3–30 English or Arabic letters, no spaces (same rule as lawmate).
  static String? name(String? value, [String? fieldName]) {
    final field = fieldName ?? _l10n.validationNameField;
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationFieldRequired(field);
    }
    final trimmed = value.trim();
    if (trimmed.length < 3 || trimmed.length > 30) {
      return _l10n.validationFieldLength(field, 3, 30);
    }
    if (!_lettersOnlyRegex.hasMatch(trimmed)) {
      return _l10n.validationLettersOnly(field);
    }
    return null;
  }

  // ──────────────────────────── Birthdate ────────────────────────────

  static final _dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  /// A real yyyy-MM-dd date in the past, at least [minimumAge] years ago.
  static String? birthdate(String? value, {int minimumAge = 20}) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationBirthdateRequired;
    }
    final trimmed = value.trim();
    if (!_dateRegex.hasMatch(trimmed)) {
      return _l10n.validationBirthdateInvalid;
    }
    final parts = trimmed.split('-').map(int.parse).toList();
    final date = DateTime(parts[0], parts[1], parts[2]);
    // DateTime rolls invalid dates over (e.g. Feb 30 → Mar 2).
    if (parts[0] < 1900 || date.month != parts[1] || date.day != parts[2]) {
      return _l10n.validationBirthdateInvalid;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (!date.isBefore(today)) {
      return _l10n.validationBirthdateFuture;
    }
    if (date.isAfter(DateTime(today.year - minimumAge, today.month, today.day))) {
      return _l10n.validationMinimumAge(minimumAge);
    }
    return null;
  }

  // ──────────────────────────── URL ────────────────────────────

  static final _urlRegex = RegExp(
    r'^https?:\/\/([\w\-]+(\.[\w\-]+)+)(\/[\w\-._~:/?#\[\]@!$&()*+,;=%]*)?$',
  );

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationUrlRequired;
    }
    if (!_urlRegex.hasMatch(value.trim())) return _l10n.validationUrlInvalid;
    return null;
  }

  // ──────────────────────────── Number ────────────────────────────

  static String? numeric(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return _requiredMessage(fieldName);
    }
    if (double.tryParse(value.trim()) == null) {
      return fieldName == null
          ? _l10n.validationMustBeNumber
          : _l10n.validationFieldMustBeNumber(fieldName);
    }
    return null;
  }

  static String? numericRange(
    String? value, {
    required double min,
    required double max,
    String? fieldName,
  }) {
    final field = fieldName ?? _l10n.validationValueField;
    final error = numeric(value, field);
    if (error != null) return error;
    final number = double.parse(value!.trim());
    if (number < min || number > max) {
      return _l10n.validationFieldRange(field, min, max);
    }
    return null;
  }

  // ──────────────────────────── Length ────────────────────────────

  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return _requiredMessage(fieldName);
    }
    if (value.trim().length < min) {
      return fieldName == null
          ? _l10n.validationMinLength(min)
          : _l10n.validationFieldMinLength(fieldName, min);
    }
    return null;
  }

  static String? maxLength(String? value, int max, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return _requiredMessage(fieldName);
    }
    if (value.trim().length > max) {
      return fieldName == null
          ? _l10n.validationMaxLength(max)
          : _l10n.validationFieldMaxLength(fieldName, max);
    }
    return null;
  }

  // ──────────────────────────── OTP / PIN ────────────────────────────

  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationOtpRequired;
    }
    if (value.trim().length != length || int.tryParse(value.trim()) == null) {
      return _l10n.validationOtpLength(length);
    }
    return null;
  }

  // ──────────────────────────── Credit Card ────────────────────────────

  static final _cardRegex = RegExp(r'^\d{13,19}$');

  static String? creditCard(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationCardRequired;
    }
    final digits = value.replaceAll(RegExp(r'\s|-'), '');
    if (!_cardRegex.hasMatch(digits)) return _l10n.validationCardInvalid;
    return null;
  }

  // ──────────────────────────── National ID ────────────────────────────

  static String? nationalId(String? value, {int length = 14}) {
    if (value == null || value.trim().isEmpty) {
      return _l10n.validationNationalIdRequired;
    }
    final trimmed = value.trim();
    if (trimmed.length != length || int.tryParse(trimmed) == null) {
      return _l10n.validationNationalIdLength(length);
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

  /// "This field is required" or "{fieldName} is required".
  static String _requiredMessage(String? fieldName) => fieldName == null
      ? _l10n.validationRequired
      : _l10n.validationFieldRequired(fieldName);
}
