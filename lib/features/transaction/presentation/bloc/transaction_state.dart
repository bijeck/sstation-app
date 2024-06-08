part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
  
  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}


final class TransactionsLoading extends TransactionState {}

final class TransactionsEmpty extends TransactionState {}

final class TransactionsError extends TransactionState {
  final String message;
  const TransactionsError({required this.message});
  @override
  List<Object> get props => [message];
}

final class TransactionsListLoaded extends TransactionState {
  final TransactionsList transactions;
  const TransactionsListLoaded({
    required this.transactions,
  });

  @override
  List<Object> get props =>
      [transactions.transactions.length, transactions.reachMax, transactions.currentPage];
}

final class TransactionLoaded extends TransactionState {
  final Transaction transaction;
  const TransactionLoaded({required this.transaction});
}