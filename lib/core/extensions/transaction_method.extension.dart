import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/res/media_res.dart';

extension TransactionMethodExt on TransactionMethod {
  String get title {
    switch (this) {
      case TransactionMethod.cash:
        return 'Cash';
      case TransactionMethod.wallet:
        return 'Wallet';
      case TransactionMethod.momo:
        return 'Momo';
      case TransactionMethod.vnpay:
        return 'Vnpay';
      default:
        return 'Unknown';
    }
  }

  String get image {
    switch (this) {
      case TransactionMethod.cash:
        return MediaRes.money;
      case TransactionMethod.wallet:
        return MediaRes.money;
      case TransactionMethod.momo:
        return MediaRes.momo;
      case TransactionMethod.vnpay:
        return MediaRes.vnpay;
      default:
        return MediaRes.money;
    }
  }
}
