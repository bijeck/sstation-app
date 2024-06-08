import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/auth/domain/repos/auth_repo.dart';

@LazySingleton()
class SignOut extends UsecaseWithoutParams<void> {
  const SignOut(this._repo);

  final AuthRepo _repo;


  @override
  ResultFuture<void> call() => _repo.signOut();
}
