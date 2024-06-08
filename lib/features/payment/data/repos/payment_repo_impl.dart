import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/errors/failure.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/payment/data/datasources/payment_datasource.dart';
import 'package:sstation/features/payment/domain/repos/payment_repo.dart';

@LazySingleton(as: PaymentRepo)
class PaymentRepoImpl extends PaymentRepo {
  const PaymentRepoImpl(this._dataSource);
  final PaymentDataSource _dataSource;

  @override
  ResultFuture<void> deposit({
    required int money,
    required PaymentProvider provider,
  }) async {
    try {
      await _dataSource.deposit(money: money, provider: provider);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> withdraw({
    required int money,
    required String id,
    required PaymentProvider provider,
  }) async {
    try {
      await _dataSource.withdraw(money: money, provider: provider, id: id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
