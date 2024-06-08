// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class DepositEvent extends PaymentEvent {
  const DepositEvent({
    required this.money,
    required this.provider,
  });

  final int money;
  final PaymentProvider provider;
}

class WithdrawEvent extends PaymentEvent {
  const WithdrawEvent({
    required this.money,
    required this.provider,
    required this.id,
  });

  final int money;
  final String id;
  final PaymentProvider provider;
}
