import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/data/models/user.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

typedef LoginParams = ({String phone, String otpCode});

class LoginUseCase extends BaseUseCase<LoginParams, User> {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future<ApiResult<User>> call(LoginParams params) async {
    // Skip global 401 handler — on the login screen a 401 means
    // a wrong code, not an expired token.
    return await networkRequest(
      () => _authRepo.login(phone: params.phone, otpCode: params.otpCode),
      handleError: (_) {},
    );
  }
}
