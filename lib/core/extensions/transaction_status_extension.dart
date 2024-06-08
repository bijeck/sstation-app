import 'package:sstation/core/enums/transaction.dart';

extension TransactionStatusExt on TransactionStatus {
  String get title {
    switch (this) {
      case TransactionStatus.processing:
        return 'Processing';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.completed:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
