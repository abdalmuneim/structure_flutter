import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_button.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_textfield.dart';
import 'package:structure_flutter/presentaions/modules/register/providers/register_provider.dart';

class RegisterScene extends BaseScene<RegisterProvider, void> {
  const RegisterScene({super.key});

  @override
  BaseSceneState<RegisterProvider, void> createState() =>
      _RegisterSceneState();
}

class _RegisterSceneState extends BaseSceneState<RegisterProvider, void> {
  @override
  Widget buildWidget(BuildContext context, RegisterProvider p) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Curved gradient header
            ClipPath(
              clipper: _WaveCurveClipper(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 24,
                  bottom: 60,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      Color(0xFF01468A),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_hospital,
                        size: 40,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign up to get started',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Form section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: p.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: p.registerForm.userNameController,
                      validator: (value) => AppValidator.required(value),
                      title: 'Full Name',
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.registerForm.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AppValidator.email(value),
                      title: 'Email',
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.registerForm.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) => AppValidator.required(value),
                      title: 'Phone',
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.registerForm.genderController,
                      title: 'Gender (optional)',
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.registerForm.passwordController,
                      obscureText: p.obscurePassword,
                      validator: (value) => AppValidator.password(value),
                      title: 'Password',
                      suffix: GestureDetector(
                        onTap: p.togglePasswordVisibility,
                        child: Icon(
                          p.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller:
                          p.registerForm.passwordConfirmationController,
                      obscureText: p.obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value !=
                            p.registerForm.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      title: 'Confirm Password',
                      suffix: GestureDetector(
                        onTap: p.toggleConfirmPasswordVisibility,
                        child: Icon(
                          p.obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      title: 'Register',
                      gradient: true,
                      shadow: true,
                      onPressed: () => p.register(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(RoutePath.login),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void listenToState(BuildContext context, RegisterProvider p) {
    log('Listening to RegisterProvider state changes');
  }
}

class _WaveCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    final firstControlPoint = Offset(size.width * 0.25, size.height);
    final firstEndPoint = Offset(size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height - 40);
    final secondEndPoint = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
