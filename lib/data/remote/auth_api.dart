import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:structure_flutter/core/networking/apis_constant.dart';
import 'package:structure_flutter/data/models/api_response.dart';
import 'package:structure_flutter/data/models/handshake.dart';
import 'package:structure_flutter/data/models/login_request.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';

part 'auth_api.g.dart';

/// HTTP endpoints for authentication. Only used by [AuthRepoImp];
/// the rest of the app talks to `AuthRepo`.
///
/// No baseUrl here: requests use Dio's, which comes from the environment.
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST(ApiConstants.handshake)
  Future<ApiResponse<HandshakeResult>> handshake(
    @Body() HandshakeRequest request,
  );

  @POST(ApiConstants.login)
  Future<ApiResponse<User>> login(@Body() LoginRequest request);

  @POST(ApiConstants.register)
  Future<ApiResponse<User>> register(@Body() RegisterRequest request);

  @POST(ApiConstants.verifyOtp)
  Future<ApiResponse<User>> verifyOtp(@Body() VerifyOtpRequest request);

  @POST(ApiConstants.resendOtp)
  Future<void> resendOtp();
}
