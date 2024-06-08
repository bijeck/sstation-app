import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/errors/failure.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/domain/entities/transactions_list.dart';
import 'package:sstation/features/transaction/domain/repos/transaction_repo.dart';

@LazySingleton(as: TransactionRepo)
class TransactionRepoImpl extends TransactionRepo {
  final TransactionDatasource _datasource;

  TransactionRepoImpl(this._datasource);
  @override
  ResultFuture<Transaction> getTransaction({
    required String? id,
    required Transaction? transaction,
  }) async {
    try {
      if (transaction != null) {
        return Right(transaction);
      } else {
        final result = await _datasource.getTransaction(
          id: id!,
        );
        return Right(result);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<TransactionsList> gettransactionsList({
    required TransactionType? type,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  }) async {
    try {
      final result = await _datasource.getTransactionsList(
        type: type,
        from: from,
        to: to,
        pageIndex: pageIndex,
        pageSize: pageSize,
        sortColumn: sortColumn,
        sortDir: sortDir,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
