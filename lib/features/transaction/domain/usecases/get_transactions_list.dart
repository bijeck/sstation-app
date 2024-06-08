import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/transaction/domain/entities/transactions_list.dart';
import 'package:sstation/features/transaction/domain/repos/transaction_repo.dart';

@LazySingleton()
class GetTransactionsList
    extends UsecaseWithParams<TransactionsList, GetTransactionsListParams> {
  final TransactionRepo _repo;

  GetTransactionsList(this._repo);

  @override
  ResultFuture<TransactionsList> call(GetTransactionsListParams param) =>
      _repo.gettransactionsList(
        type: param.type,
        from: param.from,
        to: param.to,
        pageIndex: param.pageIndex,
        pageSize: param.pageSize,
        sortColumn: param.sortColumn,
        sortDir: param.sortDir,
      );
}

class GetTransactionsListParams extends Equatable {
  const GetTransactionsListParams({
    this.type,
    this.from,
    this.to,
    required this.pageIndex,
    required this.pageSize,
    this.sortColumn,
    this.sortDir,
  });

  final TransactionType? type;
  final String? from;
  final String? to;
  final int pageIndex;
  final int pageSize;
  final String? sortColumn;
  final SortDirection? sortDir;

  @override
  List<String> get props => [];
}
