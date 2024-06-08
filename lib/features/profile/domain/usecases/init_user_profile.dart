import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/profile/domain/repos/user_profile_repo.dart';

@LazySingleton()
class InitUserProfile extends UsecaseWithoutParams<LocalUser> {
  const InitUserProfile(this._repo);

  final UserRepo _repo;

  @override
  ResultFuture<LocalUser> call() => _repo.initUserProfile();
}
