import 'dart:async';

import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/domain/use_cases/login_use_case.dart';
import 'package:structure_flutter/domain/use_cases/resend_otp_use_case.dart';
import 'package:structure_flutter/domain/use_cases/verify_registration_otp_use_case.dart';
import 'package:structure_flutter/presentation/modules/otp/models/otp_mode.dart';

class OtpProvider extends BaseProvider {
  OtpProvider({
    required this.mode,
    required this.phone,
    required LoginUseCase loginUseCase,
    required VerifyRegistrationOtpUseCase verifyRegistrationOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  }) : _loginUseCase = loginUseCase,
       _verifyRegistrationOtpUseCase = verifyRegistrationOtpUseCase,
       _resendOtpUseCase = resendOtpUseCase {
    _startCountdown();
  }

  static const codeLength = 4;
  static const resendAfterSeconds = 60;

  final OtpMode mode;

  /// International format, e.g. +201012345678.
  final String phone;

  final LoginUseCase _loginUseCase;
  final VerifyRegistrationOtpUseCase _verifyRegistrationOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  Timer? _timer;
  int _remainingSeconds = resendAfterSeconds;

  /// Seconds until the code can be sent again; 0 means it can be resent now.
  int get remainingSeconds => _remainingSeconds;

  Future<void> verify() async {
    if (!formKey.currentState!.validate()) return;
    final code = codeController.text.trim();

    switch (mode) {
      case OtpMode.login:
        await runUseCase(
          () => _loginUseCase((phone: phone, otpCode: code)),
          onSuccess: (_) => navigateTo(RoutePath.main, clearStack: true),
        );
      case OtpMode.registration:
        await runUseCase(
          () => _verifyRegistrationOtpUseCase(code),
          onSuccess: (_) => navigateTo(RoutePath.main, clearStack: true),
        );
    }
  }

  Future<void> resend() async {
    if (_remainingSeconds > 0) return;
    await runUseCase(
      () => _resendOtpUseCase(const NoParams()),
      onSuccess: (_) {
        codeController.clear();
        showSuccess('OTP sent again');
        _startCountdown();
      },
    );
  }

  /// After register the account already exists, so going back to the form
  /// makes no sense: start again from the phone screen (same as lawmate).
  void backToLogin() => navigateTo(RoutePath.login, clearStack: true);

  void _startCountdown() {
    _timer?.cancel();
    _remainingSeconds = resendAfterSeconds;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      if (_remainingSeconds <= 0) {
        _remainingSeconds = 0;
        timer.cancel();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    codeController.dispose();
    super.dispose();
  }
}
