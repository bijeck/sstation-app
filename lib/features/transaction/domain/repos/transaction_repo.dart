import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/domain/entities/transactions_list.dart';

abstract class TransactionRepo {
  const TransactionRepo();

  ResultFuture<TransactionsList> gettransactionsList({
    required TransactionType? type,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
  ResultFuture<Transaction> getTransaction({
    required String? id,
    required Transaction? transaction,
  });
}