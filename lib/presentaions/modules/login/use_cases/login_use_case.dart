import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/core/networking/api_service.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_request.dart';
import 'package:structure_flutter/presentaions/modules/login/models/login_response.dart';

class LoginUseCase extends BaseUseCase<LoginRequest, LoginResponse> {
  final ApiService _apiService;

  LoginUseCase(this._apiService);

  @override
  Future<ApiResult<LoginResponse>> call(LoginRequest params) async {
    // Skip global 401 handler — on the login screen a 401 means
    // wrong credentials, not an expired token.
    return await networkRequest(
      () => _apiService.login(params.toJson()),
      handleError: (_) {},
    );
  }
}
