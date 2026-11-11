import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String? email;
  final String? password;
  final String? phone;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'device_id')
  final String? deviceId;
  @JsonKey(name: 'device_type')
  final String? deviceType;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  final String? language;
  @JsonKey(name: 'country_code')
  final String? countryCode;

  LoginRequest({
    this.email,
    this.password,
    this.phone,
    this.userName,
    this.deviceId,
    this.deviceType,
    this.fcmToken,
    this.language,
    this.countryCode,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
