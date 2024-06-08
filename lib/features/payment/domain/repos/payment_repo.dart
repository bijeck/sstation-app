import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/utils/typedefs.dart';

abstract class PaymentRepo {
  const PaymentRepo();

  ResultFuture<void> deposit({
    required int money,
    required PaymentProvider provider,
  });
  ResultFuture<void> withdraw({
    required int money,
    required String id,
    required PaymentProvider provider,
  });
}
