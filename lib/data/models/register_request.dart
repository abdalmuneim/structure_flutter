import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String? email;
  final String? password;
  @JsonKey(name: 'password_confirmation')
  final String? passwordConfirmation;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? phone;
  final String? gender;
  @JsonKey(name: 'device_id')
  final String? deviceId;
  @JsonKey(name: 'device_type')
  final String? deviceType;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  final String? language;

  RegisterRequest({
    this.email,
    this.password,
    this.passwordConfirmation,
    this.userName,
    this.phone,
    this.gender,
    this.deviceId,
    this.deviceType,
    this.fcmToken,
    this.language,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
