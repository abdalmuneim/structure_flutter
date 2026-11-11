import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:structure_flutter/core/bases/base_scene.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/core/localization/l10n_extension.dart';
import 'package:structure_flutter/presentation/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentation/components/widgets/app_button.dart';
import 'package:structure_flutter/presentation/components/widgets/auth_header.dart';
import 'package:structure_flutter/presentation/modules/otp/models/otp_mode.dart';
import 'package:structure_flutter/presentation/modules/otp/providers/otp_provider.dart';

class OtpScene extends BaseScene<OtpProvider> {
  const OtpScene({super.key});

  @override
  BaseSceneState<OtpProvider> createState() => _OtpSceneState();
}

class _OtpSceneState extends BaseSceneState<OtpProvider> {
  @override
  Widget buildWidget(BuildContext context, OtpProvider p) {
    final isRegistration = p.mode == OtpMode.registration;

    return PopScope(
      canPop: !isRegistration,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) p.backToLogin();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeader(
                title: context.l10n.otpTitle(OtpProvider.codeLength),
                subtitle: context.l10n.otpSubtitle(p.phone),
                icon: Icons.sms_outlined,
                onBack: isRegistration ? p.backToLogin : navigator.maybePop,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: p.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      _CodeField(
                        controller: p.codeController,
                        onCompleted: p.verify,
                      ),
                      const SizedBox(height: 28),
                      AppButton(
                        title: context.l10n.commonContinue,
                        gradient: true,
                        shadow: true,
                        onPressed: p.verify,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 24),
                      _resendRow(p),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resendRow(OtpProvider p) {
    if (p.remainingSeconds > 0) {
      final minutes = (p.remainingSeconds ~/ 60).toString().padLeft(2, '0');
      final seconds = (p.remainingSeconds % 60).toString().padLeft(2, '0');
      return Text(
        context.l10n.otpResendCountdown('$minutes:$seconds'),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.otpDidNotReceive,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        TextButton(onPressed: p.resend, child: Text(context.l10n.otpResend)),
      ],
    );
  }
}

/// One field for the whole code; submits by itself when all digits are in.
class _CodeField extends StatelessWidget {
  const _CodeField({required this.controller, required this.onCompleted});

  final TextEditingController controller;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      autofillHints: const [AutofillHints.oneTimeCode],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(OtpProvider.codeLength),
      ],
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 24,
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        hintText: '0000',
        hintStyle: TextStyle(color: Colors.grey[300], letterSpacing: 24),
        filled: true,
        fillColor: AppColors.fourth,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) =>
          AppValidator.otp(value, length: OtpProvider.codeLength),
      onChanged: (value) {
        if (value.length == OtpProvider.codeLength) onCompleted();
      },
    );
  }
}
