import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

class ResendOtpUseCase extends BaseUseCase<NoParams, void> {
  final AuthRepo _authRepo;

  ResendOtpUseCase(this._authRepo);

  @override
  Future<ApiResult<void>> call(NoParams params) {
    return networkRequest(() => _authRepo.resendOtp());
  }
}
