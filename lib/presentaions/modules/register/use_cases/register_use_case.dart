import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/core/networking/api_service.dart';
import 'package:structure_flutter/presentaions/modules/register/models/register_request.dart';
import 'package:structure_flutter/presentaions/modules/register/models/register_response.dart';

class RegisterUseCase extends BaseUseCase<RegisterRequest, RegisterResponse> {
  final ApiService _apiService;

  RegisterUseCase(this._apiService);

  @override
  Future<ApiResult<RegisterResponse>> call(RegisterRequest params) async {
    return await networkRequest(
      () => _apiService.register(params.toJson()),
    );
  }
}
