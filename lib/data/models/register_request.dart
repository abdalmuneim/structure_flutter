import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class RegisterRequest {
  const RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.gender,
    this.language,
    this.notificationToken,
  });

  final String firstName;
  final String lastName;
  final String email;

  /// International format, e.g. +201012345678.
  final String phone;

  /// yyyy-MM-dd
  final String birthdate;

  /// "male" or "female".
  final String gender;

  /// Filled in by the repository from the saved app language.
  final String? language;
  final String? notificationToken;

  RegisterRequest withLanguage(String language) => RegisterRequest(
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    birthdate: birthdate,
    gender: gender,
    language: language,
    notificationToken: notificationToken,
  );

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
