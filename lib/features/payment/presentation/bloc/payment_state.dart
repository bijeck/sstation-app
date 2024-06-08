part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentError extends PaymentState {
  const PaymentError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

final class DepositSuccess extends PaymentState {}

final class WithdrawSuccess extends PaymentState {}
