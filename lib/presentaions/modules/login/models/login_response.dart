import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? token;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? email;
  final String? phone;

  LoginResponse({
    this.token,
    this.userName,
    this.email,
    this.phone,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
