import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
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
            AuthHeader(
              title: context.l10n.authLoginTitle,
              subtitle: context.l10n.authLoginSubtitle,
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
                      title: context.l10n.authPhoneLabel,
                      hint: '01012345678',
                      controller: p.phoneController,
                      keyboardType: TextInputType.phone,
                      // +20 and the number read left to right in Arabic too.
                      textDirection: TextDirection.ltr,
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
                      context.l10n.authLoginNewUserHint,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      title: context.l10n.commonGetStarted,
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
