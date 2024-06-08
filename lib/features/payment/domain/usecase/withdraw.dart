import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/payment/domain/repos/payment_repo.dart';

@LazySingleton()
class WithDraw extends UsecaseWithParams<void, WithDrawParams> {
  const WithDraw(this._repo);

  final PaymentRepo _repo;
  @override
  ResultFuture<void> call(WithDrawParams param) => _repo.withdraw(
        money: param.money,
        id: param.id,
        provider: param.provider,
      );
}

class WithDrawParams extends Equatable {
  const WithDrawParams({
    required this.money,
    required this.provider,
    required this.id,
  });

  final int money;
  final String id;
  final PaymentProvider provider;

  @override
  List<String> get props => [];
}
