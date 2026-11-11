import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// The account returned by login, register and verify-otp.
///
/// Only the fields the app uses so far; add more from the API as needed.
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  const User({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.gender,
    this.birthdate,
    this.profilePicture,
    this.activation,
    this.accessToken,
    this.verified = false,
  });

  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? gender;
  final String? birthdate;
  final String? profilePicture;
  final String? activation;
  final String? accessToken;

  @JsonKey(defaultValue: false)
  final bool verified;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
