import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/payment.dart';

import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/payment/domain/repos/payment_repo.dart';

@LazySingleton()
class Deposit extends UsecaseWithParams<void, DepositParams> {
  const Deposit(this._repo);

  final PaymentRepo _repo;

  @override
  ResultFuture<void> call(DepositParams param) => _repo.deposit(
        money: param.money,
        provider: param.provider,
      );
}

class DepositParams extends Equatable {
  const DepositParams({
    required this.money,
    required this.provider,
  });

  final int money;
  final PaymentProvider provider;

  @override
  List<String> get props => [];
}
