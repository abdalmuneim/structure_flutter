import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

/// The `{"data": ...}` wrapper the API puts around every successful response.
///
/// Use it as the Retrofit return type, e.g. `Future<ApiResponse<User>>`.
@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ApiResponse<T> {
  const ApiResponse({required this.data});

  final T data;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
