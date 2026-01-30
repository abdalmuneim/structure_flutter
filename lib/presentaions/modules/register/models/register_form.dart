import 'package:flutter/material.dart';

class RegisterForm {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final TextEditingController userNameController;
  final TextEditingController phoneController;
  final TextEditingController genderController;

  RegisterForm({
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required this.userNameController,
    required this.phoneController,
    required this.genderController,
  });

  List<TextEditingController> get controllers => [
        emailController,
        passwordController,
        passwordConfirmationController,
        userNameController,
        phoneController,
        genderController,
      ];

  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
  }
}
