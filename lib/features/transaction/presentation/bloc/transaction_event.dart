part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionEvent extends TransactionEvent {
  const GetTransactionEvent({
    this.id,
    this.transaction,
  });
  final String? id;
  final Transaction? transaction;
}

class GetTransactionsListEvent extends TransactionEvent {
  final TransactionType? type;
  final String? from;
  final String? to;
  const GetTransactionsListEvent({
    this.type,
    this.from,
    this.to,
  });
}

class TransactionsLoadMoreEvent extends TransactionEvent {
  final TransactionType? type;
  final String? from;
  final String? to;
  const TransactionsLoadMoreEvent({
    this.type,
    this.from,
    this.to,
  });
}