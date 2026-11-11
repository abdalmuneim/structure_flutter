import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
import 'package:structure_flutter/presentation/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentation/components/widgets/app_button.dart';
import 'package:structure_flutter/presentation/components/widgets/app_textfield.dart';
import 'package:structure_flutter/presentation/components/widgets/auth_header.dart';
import 'package:structure_flutter/presentation/components/widgets/input_error.dart';
import 'package:structure_flutter/presentation/modules/register/providers/register_provider.dart';

class RegisterScene extends BaseScene<RegisterProvider> {
  const RegisterScene({super.key});

  @override
  BaseSceneState<RegisterProvider> createState() => _RegisterSceneState();
}

class _RegisterSceneState extends BaseSceneState<RegisterProvider> {
  @override
  Widget buildWidget(BuildContext context, RegisterProvider p) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(
              title: p.accountCreated
                  ? context.l10n.registerSuccessTitle
                  : context.l10n.registerTitle,
              subtitle: p.accountCreated
                  ? context.l10n.registerSuccessSubtitle(p.phone)
                  : context.l10n.registerSubtitle(p.phone),
              onBack: p.accountCreated ? null : () => navigator.maybePop(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: p.accountCreated ? _success(p) : _form(p),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(RegisterProvider p) {
    final l10n = context.l10n;
    return Form(
      key: p.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          AppTextField(
            title: l10n.registerFirstNameLabel,
            controller: p.firstNameController,
            validator: (value) =>
                AppValidator.name(value, l10n.registerFirstNameField),
          ),
          const SizedBox(height: 16),
          AppTextField(
            title: l10n.registerLastNameLabel,
            controller: p.lastNameController,
            validator: (value) =>
                AppValidator.name(value, l10n.registerLastNameField),
          ),
          const SizedBox(height: 16),
          AppTextField(
            title: l10n.registerEmailLabel,
            controller: p.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.email,
          ),
          const SizedBox(height: 16),
          AppTextField(
            title: l10n.registerBirthdateLabel,
            hint: 'yyyy-mm-dd',
            controller: p.birthdateController,
            readOnly: true,
            onTap: () => _pickBirthdate(p),
            endIcon: const Icon(Icons.calendar_today, size: 18),
            validator: (value) => AppValidator.birthdate(value),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.registerGenderLabel,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final gender in RegisterProvider.genders) ...[
                ChoiceChip(
                  label: Text(
                    gender == 'male'
                        ? l10n.registerGenderMale
                        : l10n.registerGenderFemale,
                  ),
                  selected: p.gender == gender,
                  onSelected: (_) => p.selectGender(gender),
                  selectedColor: AppColors.primary.withValues(alpha: 0.15),
                ),
                const SizedBox(width: 12),
              ],
            ],
          ),
          if (p.showGenderError) inputError(l10n.registerGenderRequired),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: p.termsAccepted,
                activeColor: AppColors.primary,
                onChanged: (value) => p.setTermsAccepted(value ?? false),
              ),
              Expanded(
                child: Text(
                  l10n.registerAcceptTerms,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          AppButton(
            title: l10n.commonContinue,
            gradient: true,
            shadow: true,
            onPressed: p.register,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _success(RegisterProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        const Icon(Icons.check_circle, size: 72, color: AppColors.success),
        const SizedBox(height: 16),
        Text(
          context.l10n.registerSuccessMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
        ),
        const SizedBox(height: 32),
        AppButton(
          title: context.l10n.registerVerifyPhone,
          gradient: true,
          shadow: true,
          onPressed: p.continueToVerification,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// Must be at least 20 years old, same limits as lawmate.
  Future<void> _pickBirthdate(RegisterProvider p) async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year - 20, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: p.birthdate ?? lastDate,
      firstDate: DateTime(now.year - 100),
      lastDate: lastDate,
    );
    if (picked != null) p.setBirthdate(picked);
  }
}
