import 'package:sstation/core/enums/transaction.dart';

extension TransactionTypeExt on TransactionType {
  String get title {
    switch (this) {
      case TransactionType.deposit:
        return 'Deposit';
      case TransactionType.withdraw:
        return 'Withdraw';
      case TransactionType.pay:
        return 'Pay';
      case TransactionType.receive:
        return 'Receive';
      default:
        throw UnsupportedError(
            'TransactionType not include any value name ${toString()}');
    }
  }
  
}
