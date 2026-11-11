import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/data/models/user.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

/// Confirms the code sent after register. Params: the code.
class VerifyRegistrationOtpUseCase extends BaseUseCase<String, User> {
  final AuthRepo _authRepo;

  VerifyRegistrationOtpUseCase(this._authRepo);

  @override
  Future<ApiResult<User>> call(String otpCode) {
    return networkRequest(() => _authRepo.verifyRegistrationOtp(otpCode));
  }
}
