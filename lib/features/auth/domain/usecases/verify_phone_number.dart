import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/auth/domain/repos/auth_repo.dart';

@LazySingleton()
class VerifyPhoneNumber extends UsecaseWithParams<void, String> {
  const VerifyPhoneNumber(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String param) =>
      _repo.verifyPhoneNumber(phoneNumber: param);
}
