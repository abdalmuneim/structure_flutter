import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:structure_flutter/core/networking/apis_constant.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_response.dart';
import 'package:structure_flutter/presentaions/modules/register/models/register_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.signup)
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);
}
