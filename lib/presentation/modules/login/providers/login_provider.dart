import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_provider.dart';
import 'package:structure_flutter/core/helpers/phone_number.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/domain/use_cases/handshake_use_case.dart';

/// Phone entry, the first step of login and register (lawmate's handshake).
///
/// The server says whether the phone has an account: existing → login OTP,
/// new → register form.
class LoginProvider extends BaseProvider {
  LoginProvider(this._handshakeUseCase);

  final HandshakeUseCase _handshakeUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  Future<void> continueWithPhone() async {
    if (!formKey.currentState!.validate()) return;

    final phone = PhoneNumber.egyptianInternational(phoneController.text);

    await runUseCase(
      () => _handshakeUseCase(phone),
      onSuccess: (isRegistered) => navigateTo(
        isRegistered ? RoutePath.loginOtp : RoutePath.registerScene,
        arguments: phone,
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
