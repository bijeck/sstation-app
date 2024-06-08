// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/payment/domain/usecase/deposit.dart';
import 'package:sstation/features/payment/domain/usecase/withdraw.dart';

part 'payment_event.dart';
part 'payment_state.dart';

@Injectable()
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required Deposit deposit,
    required WithDraw withdraw,
  })  : _deposit = deposit,
        _withdraw = withdraw,
        super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {
      emit(PaymentLoading());
    });
    on<DepositEvent>(_depositHandler);
    on<WithdrawEvent>(_withdrawHandler);
  }

  final Deposit _deposit;
  final WithDraw _withdraw;

  FutureOr<void> _depositHandler(
    DepositEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _deposit(
      DepositParams(
        money: event.money,
        provider: event.provider,
      ),
    );
    result.fold(
      (failure) => emit(PaymentError(int.parse(failure.statusCode) == 401
          ? AppMessage.unauthorized
          : AppMessage.serverError)),
      (token) => emit(DepositSuccess()),
    );
  }

  FutureOr<void> _withdrawHandler(
    WithdrawEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _withdraw(
      WithDrawParams(
        money: event.money,
        provider: event.provider,
        id: event.id,
      ),
    );
    result.fold(
      (failure) => emit(PaymentError(int.parse(failure.statusCode) == 400
          ? failure.errorMessage
          : AppMessage.serverError)),
      (token) => emit(WithdrawSuccess()),
    );
  }
}
