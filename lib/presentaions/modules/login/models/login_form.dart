import 'package:flutter/material.dart';

class LoginForm {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;
  final String deviceIdController;
  final String deviceTypeController;
  final String fcmTokenController;
  final String languageController;
  final TextEditingController countryCodeController;
  final TextEditingController userNameController;

  LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
    required this.deviceIdController,
    required this.deviceTypeController,
    required this.fcmTokenController,
    required this.languageController,
    required this.countryCodeController,
    required this.userNameController,
  });

  List<TextEditingController> get controllers => [
    emailController,
    passwordController,
    phoneNumberController,
    countryCodeController,
    userNameController,
  ];

  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
  }
}
