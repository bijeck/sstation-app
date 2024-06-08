import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/domain/entities/transactions_list.dart';
import 'package:sstation/features/transaction/domain/usecases/get_transaction.dart';
import 'package:sstation/features/transaction/domain/usecases/get_transactions_list.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@Injectable()
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionsList transactions = TransactionsList(
    transactions: [],
    currentPage: 1,
    reachMax: false,
  );
  TransactionBloc(
    GetTransactionsList getTransactionsList,
    GetTransaction getTransaction,
  )   : _getTransactionsList = getTransactionsList,
        _getTransaction = getTransaction,
        super(TransactionInitial()) {
    on<TransactionsLoadMoreEvent>(_loadMoreHandler);
    on<GetTransactionsListEvent>(_getTransactionsListHandler);
    on<GetTransactionEvent>(_getTransactionHandler);
  }

  final GetTransactionsList _getTransactionsList;
  final GetTransaction _getTransaction;

  Future<void> _loadMoreHandler(
    TransactionsLoadMoreEvent event,
    Emitter<TransactionState> emit,
  ) async {
    bool isInitial = transactions.currentPage == 1;
    if (isInitial) {
      emit(TransactionsLoading());
    }
    final result = await _getTransactionsList(GetTransactionsListParams(
      type: event.type,
      from: event.from,
      to: event.to,
      pageIndex: isInitial ? 1 : transactions.currentPage,
      pageSize: 15,
      sortColumn: 'createdAt',
      sortDir: SortDirection.desc,
    ));
    result.fold(
        (failure) => emit(TransactionsError(message: AppMessage.serverError)),
        (loadedTransactions) {
      if (loadedTransactions.transactions.isEmpty) {
        transactions = TransactionsList(
            transactions:
                transactions.transactions + loadedTransactions.transactions,
            currentPage: transactions.currentPage,
            reachMax: loadedTransactions.reachMax);
        emit(TransactionsListLoaded(transactions: transactions));
      } else {
        //Adding products to existing list
        transactions = TransactionsList(
            transactions:
                transactions.transactions + loadedTransactions.transactions,
            currentPage: transactions.currentPage + 1,
            reachMax: loadedTransactions.reachMax);
        emit(TransactionsListLoaded(transactions: transactions));
      }
    });
  }

  Future<void> _getTransactionsListHandler(
    GetTransactionsListEvent event,
    Emitter<TransactionState> emit,
  ) async {
    bool isInitial = true;
    transactions = TransactionsList.reset();
    if (isInitial) {
      emit(TransactionsLoading());
    }
    final result = await _getTransactionsList(GetTransactionsListParams(
      type: event.type,
      pageIndex: 1,
      pageSize: 15,
      from: event.from,
      to: event.to,
      sortColumn: 'createdAt',
      sortDir: SortDirection.desc,
    ));
    result.fold(
        (failure) => emit(TransactionsError(message: AppMessage.serverError)),
        (loadedTransactions) {
      if (loadedTransactions.transactions.isEmpty) {
        emit(TransactionsEmpty());
      } else {
        transactions = TransactionsList(
            transactions: loadedTransactions.transactions,
            currentPage: transactions.currentPage + 1,
            reachMax: loadedTransactions.reachMax);
        emit(TransactionsListLoaded(transactions: transactions));
      }
    });
  }

  Future<void> _getTransactionHandler(
    GetTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionsLoading());
    final result = await _getTransaction(
      GetTransactionParams(
        id: event.id,
        transaction: event.transaction,
      ),
    );
    result.fold(
      (failure) => emit(TransactionsError(message: AppMessage.serverError)),
      (loadedTransaction) =>
          emit(TransactionLoaded(transaction: loadedTransaction)),
    );
  }
}
