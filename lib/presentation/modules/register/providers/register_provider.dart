import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/domain/use_cases/register_use_case.dart';

/// Register form for a phone that has no account yet (from the phone screen).
///
/// After the account is created the screen shows a success step; continuing
/// opens the OTP screen to confirm the phone.
class RegisterProvider extends BaseProvider {
  RegisterProvider(this._registerUseCase, {required this.phone});

  final RegisterUseCase _registerUseCase;

  /// International format, e.g. +201012345678.
  final String phone;

  static const genders = ['male', 'female'];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  /// Shows the picked date as yyyy-MM-dd, the format the API expects.
  final TextEditingController birthdateController = TextEditingController();

  DateTime? _birthdate;
  DateTime? get birthdate => _birthdate;

  String? _gender;
  String? get gender => _gender;

  bool _showGenderError = false;
  bool get showGenderError => _showGenderError;

  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;

  bool _accountCreated = false;
  bool get accountCreated => _accountCreated;

  void setBirthdate(DateTime date) {
    _birthdate = date;
    birthdateController.text =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    notifyListeners();
  }

  void selectGender(String gender) {
    _gender = gender;
    _showGenderError = false;
    notifyListeners();
  }

  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  Future<void> register() async {
    if (!_termsAccepted) {
      showError(AppL10n.current.registerTermsRequired);
      return;
    }

    final isFormValid = formKey.currentState!.validate();
    _showGenderError = _gender == null;
    notifyListeners();
    if (!isFormValid || _gender == null) return;

    final request = RegisterRequest(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phone,
      birthdate: birthdateController.text,
      gender: _gender!,
    );

    await runUseCase(
      () => _registerUseCase(request),
      onSuccess: (_) {
        _accountCreated = true;
        notifyListeners();
      },
    );
  }

  void continueToVerification() {
    navigateTo(RoutePath.registerOtp, arguments: phone);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    birthdateController.dispose();
    super.dispose();
  }
}
