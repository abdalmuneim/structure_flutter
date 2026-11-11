import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/presentation/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentation/components/widgets/app_button.dart';
import 'package:structure_flutter/presentation/components/widgets/app_textfield.dart';
import 'package:structure_flutter/presentation/components/widgets/auth_header.dart';
import 'package:structure_flutter/presentation/modules/login/providers/login_provider.dart';

class LoginScene extends BaseScene<LoginProvider> {
  const LoginScene({super.key});

  @override
  BaseSceneState<LoginProvider> createState() => _LoginSceneState();
}

class _LoginSceneState extends BaseSceneState<LoginProvider> {
  @override
  Widget buildWidget(BuildContext context, LoginProvider p) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
              title: 'Let’s Sign In',
              subtitle: 'Enter your phone number to get started',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: p.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    AppTextField(
                      title: 'Phone Number',
                      hint: '01012345678',
                      controller: p.phoneController,
                      keyboardType: TextInputType.phone,
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '+20',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      formatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: AppValidator.egyptianPhone,
                      onSubmit: (_) => p.continueWithPhone(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'New here? You will create your account in the next step.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      title: 'Get Started',
                      gradient: true,
                      shadow: true,
                      onPressed: p.continueWithPhone,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
}
