import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:sstation/features/auth/domain/repos/auth_repo.dart';

@LazySingleton()
class SignIn extends UsecaseWithParams<UserToken, SignInParams> {
  const SignIn(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<UserToken> call(SignInParams param) => _repo.signIn(
        phoneNumber: param.phoneNumber,
        password: param.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.phoneNumber,
    required this.password,
  });

  const SignInParams.empty()
      : phoneNumber = '',
        password = '';

  final String phoneNumber;
  final String password;

  @override
  List<String> get props => [phoneNumber, password];
}
