import 'package:json_annotation/json_annotation.dart';

part 'handshake.g.dart';

@JsonSerializable(createFactory: false)
class HandshakeRequest {
  const HandshakeRequest({required this.phone});

  /// International format, e.g. +201012345678.
  final String phone;

  Map<String, dynamic> toJson() => _$HandshakeRequestToJson(this);
}

@JsonSerializable(createToJson: false)
class HandshakeResult {
  const HandshakeResult({required this.isExist});

  /// True when an account already exists for the phone.
  @JsonKey(name: 'is_exist')
  final bool isExist;

  factory HandshakeResult.fromJson(Map<String, dynamic> json) =>
      _$HandshakeResultFromJson(json);
}
