import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String? token;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? email;
  final String? phone;

  RegisterResponse({
    this.token,
    this.userName,
    this.email,
    this.phone,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
