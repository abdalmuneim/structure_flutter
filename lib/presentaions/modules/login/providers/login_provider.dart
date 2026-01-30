import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/shared_pref_helper.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_form.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_request.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_response.dart';
import 'package:structure_flutter/presentaions/modules/login/use_cases/login_use_case.dart';

class LoginProvider extends BaseProvider {
  final LoginUseCase _loginUseCase;

  LoginProvider(this._loginUseCase) : super();

  final LoginForm loginForm = LoginForm(
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
    phoneNumberController: TextEditingController(),
    countryCodeController: TextEditingController(),
    userNameController: TextEditingController(),
    deviceIdController: '',
    deviceTypeController: '',
    fcmTokenController: '',
    languageController: '',
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    clearError();
    setLoading(true);

    final navigator = Navigator.of(context);
    final loginRequest = LoginRequest(
      email: loginForm.emailController.text.trim(),
      password: loginForm.passwordController.text.trim(),
      countryCode: loginForm.countryCodeController.text.trim(),
      deviceId: loginForm.deviceIdController.trim(),
      deviceType: loginForm.deviceTypeController.trim(),
      fcmToken: loginForm.fcmTokenController.trim(),
      language: loginForm.languageController.trim(),
      phone: loginForm.phoneNumberController.text.trim(),
      userName: loginForm.userNameController.text.trim(),
    );

    final result = await _loginUseCase.call(loginRequest);

    setLoading(false);

    switch (result) {
      case Success<LoginResponse>(:final data):
        await _handleLoginSuccess(navigator, data);
      case Failure<LoginResponse>(:final errorHandler):
        setError(errorHandler.apiErrorModel);
    }
  }

  Future<void> _handleLoginSuccess(
    NavigatorState navigator,
    LoginResponse response,
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
    // loginForm.dispose();
    super.dispose();
  }
}
