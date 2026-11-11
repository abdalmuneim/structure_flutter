import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/core/networking/api_result.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

/// Checks whether an account exists for a phone number.
/// Success data is true for an existing account (go to login OTP) and
/// false for a new one (go to register).
class HandshakeUseCase extends BaseUseCase<String, bool> {
  final AuthRepo _authRepo;

  HandshakeUseCase(this._authRepo);

  @override
  Future<ApiResult<bool>> call(String phone) {
    return networkRequest(() => _authRepo.handshake(phone));
  }
}
