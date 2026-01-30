import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentaions/modules/register/models/register_form.dart';
import 'package:structure_flutter/presentaions/modules/register/models/register_request.dart';
import 'package:structure_flutter/presentaions/modules/register/models/register_response.dart';
import 'package:structure_flutter/presentaions/modules/register/use_cases/register_use_case.dart';

class RegisterProvider extends BaseProvider {
  final RegisterUseCase _registerUseCase;

  RegisterProvider(this._registerUseCase) : super();

  final RegisterForm registerForm = RegisterForm(
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
    passwordConfirmationController: TextEditingController(),
    userNameController: TextEditingController(),
    phoneController: TextEditingController(),
    genderController: TextEditingController(),
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    clearError();
    setLoading(true);

    final navigator = Navigator.of(context);
    final request = RegisterRequest(
      email: registerForm.emailController.text.trim(),
      password: registerForm.passwordController.text.trim(),
      passwordConfirmation:
          registerForm.passwordConfirmationController.text.trim(),
      userName: registerForm.userNameController.text.trim(),
      phone: registerForm.phoneController.text.trim(),
      gender: registerForm.genderController.text.trim(),
    );

    final result = await _registerUseCase.call(request);

    setLoading(false);

    switch (result) {
      case Success<RegisterResponse>(:final data):
        await _handleRegisterSuccess(navigator, data);
      case Failure<RegisterResponse>(:final errorHandler):
        setError(errorHandler.apiErrorModel);
    }
  }

  Future<void> _handleRegisterSuccess(
    NavigatorState navigator,
    RegisterResponse response,
  ) async {
    if (response.token != null) {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userToken,
        response.token!,
      );
      DioFactory.setTokenIntoHeaderAfterLogin(response.token!);
    }

    navigator.pushNamedAndRemoveUntil(RoutePath.main, (route) => false);
  }

  @override
  void dispose() {
    registerForm.dispose();
    super.dispose();
  }
}
