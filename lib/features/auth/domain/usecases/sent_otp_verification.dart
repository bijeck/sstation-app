import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/auth/domain/repos/auth_repo.dart';

@LazySingleton()
class SentOTPVerification
    extends UsecaseWithParams<String, SentOTPVerificationParams> {
  const SentOTPVerification(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<String> call(SentOTPVerificationParams param) =>
      _repo.sentOTPVerification(phoneNumber: param.phoneNumber, otp: param.otp);
}

class SentOTPVerificationParams extends Equatable {
  const SentOTPVerificationParams({
    required this.phoneNumber,
    required this.otp,
  });

  const SentOTPVerificationParams.empty()
      : phoneNumber = '',
        otp = '';

  final String phoneNumber;
  final String otp;

  @override
  List<String> get props => [phoneNumber, otp];
}
