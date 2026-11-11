import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_button.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_textfield.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_form.dart';
import 'package:structure_flutter/presentaions/modules/login/providers/login_provider.dart';

class LoginScene extends BaseScene<LoginProvider, LoginForm> {
  const LoginScene({super.key});

  @override
  BaseSceneState<LoginProvider, LoginForm> createState() => _LoginSceneState();
}

class _LoginSceneState extends BaseSceneState<LoginProvider, LoginForm> {
  @override
  Widget buildWidget(BuildContext context, LoginProvider p) {
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
                  top: MediaQuery.of(context).padding.top + 32,
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
                    // Hospital icon in semi-transparent circle
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
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
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
                      controller: p.loginForm.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AppValidator.email(value),
                      title: 'Email',
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.loginForm.passwordController,
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
                    const SizedBox(height: 8),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 36),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.loginForm.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      title: 'Phone (optional)',
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: p.loginForm.userNameController,
                      title: 'Username (optional)',
                    ),
                    const SizedBox(height: 28),
                    // Login button with gradient
                    AppButton(
                      title: 'Login',
                      gradient: true,
                      shadow: true,
                      onPressed: () => p.login(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 24),
                    // Sign up text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(RoutePath.registerScene),
                          child: const Text(
                            'Sign Up',
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
  void listenToState(BuildContext context, LoginProvider p) {
    log('Listening to LoginProvider state changes');
  }
}

/// Custom clipper that creates a wave/curve at the bottom of the header.
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
