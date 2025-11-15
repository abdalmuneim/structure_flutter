import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:structure_flutter/core/networking/apis_constant.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<dynamic> login(@Body() dynamic loginRequestBody);

  @POST(ApiConstants.signup)
  Future<dynamic> signup(@Body() dynamic signupRequestBody);
}
