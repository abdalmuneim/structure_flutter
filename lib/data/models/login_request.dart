import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class LoginRequest {
  const LoginRequest({
    required this.phone,
    required this.otpCode,
    required this.language,
    this.notificationToken,
  });

  final String phone;
  final String otpCode;
  final String language;
  final String? notificationToken;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class VerifyOtpRequest {
  const VerifyOtpRequest({required this.otpCode});

  final String otpCode;

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}
