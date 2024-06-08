import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/domain/repos/transaction_repo.dart';

@LazySingleton()
class GetTransaction
    extends UsecaseWithParams<Transaction, GetTransactionParams> {
  final TransactionRepo _repo;

  GetTransaction(this._repo);

  @override
  ResultFuture<Transaction> call(GetTransactionParams param) =>
      _repo.getTransaction(
        id: param.id,
        transaction: param.transaction,
      );
}

class GetTransactionParams extends Equatable {
  const GetTransactionParams({
    this.id,
    this.transaction,
  });
  final String? id;
  final Transaction? transaction;

  @override
  List<Object?> get props => [];
}
