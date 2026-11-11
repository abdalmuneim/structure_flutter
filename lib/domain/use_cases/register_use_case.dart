import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

class RegisterUseCase extends BaseUseCase<RegisterRequest, User> {
  final AuthRepo _authRepo;

  RegisterUseCase(this._authRepo);

  @override
  Future<ApiResult<User>> call(RegisterRequest params) {
    return networkRequest(() => _authRepo.register(params));
  }
}
