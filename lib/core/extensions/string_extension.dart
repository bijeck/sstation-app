import 'package:sstation/core/enums/notification.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/enums/user.dart';

extension StringExt on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }

  PackageStatus toPackageStatus() {
    switch (toLowerCase()) {
      case 'initialized':
        return PackageStatus.initialized;
      case 'returned':
        return PackageStatus.returned;
      case 'completed':
        return PackageStatus.completed;
      case 'canceled':
        return PackageStatus.canceled;
      case 'paid':
        return PackageStatus.paid;
    }

    throw UnsupportedError('PackageStatus not include any value name $this');
  }

  UserType toUserType() {
    switch (toLowerCase()) {
      case 'sender':
        return UserType.sender;
      case 'receiver':
        return UserType.receiver;
    }

    throw UnsupportedError('UserType not include any value name $this');
  }

  TransactionStatus toTransactionStatus() {
    switch (toLowerCase()) {
      case 'failed':
        return TransactionStatus.failed;
      case 'processing':
        return TransactionStatus.processing;
      case 'completed':
        return TransactionStatus.completed;
    }

    throw UnsupportedError(
        'TransactionStatus not include any value name $this');
  }

  TransactionType toTransactionType() {
    switch (toLowerCase()) {
      case 'deposit':
        return TransactionType.deposit;
      case 'withdraw':
        return TransactionType.withdraw;
      case 'pay':
        return TransactionType.pay;
      case 'receive':
        return TransactionType.receive;
    }

    throw UnsupportedError('TransactionType not include any value name $this');
  }

  TransactionMethod toTransactionMethod() {
    switch (toLowerCase()) {
      case 'cash':
        return TransactionMethod.cash;
      case 'wallet':
        return TransactionMethod.wallet;
      case 'momo':
        return TransactionMethod.momo;
      case 'vnpay':
        return TransactionMethod.vnpay;
    }

    throw UnsupportedError(
        'TransactionMethod not include any value name $this');
  }

  NotificationType toNotificationType() {
    switch (toLowerCase()) {
      case 'verificationcode':
        return NotificationType.verificationCode;
      case 'systemstaffcreated':
        return NotificationType.systemStaffCreated;
      case 'customerpackagecreated':
        return NotificationType.customerPackageCreated;
      case 'customerpaymentpackage':
        return NotificationType.customerPaymentPackage;
      case 'customerpackagecanceled':
        return NotificationType.customerPackageCanceled;
    }

    throw UnsupportedError('NotificationType not include any value name $this');
  }

  NotificationLevel toNotificationLevel() {
    switch (toLowerCase()) {
      case 'critical':
        return NotificationLevel.critical;
      case 'warning':
        return NotificationLevel.warning;
      case 'information':
        return NotificationLevel.information;
    }

    throw UnsupportedError(
        'NotificationLevel not include any value name $this');
  }

  PaymentProvider toPaymentProvider() {
    switch (toLowerCase()) {
      case 'momo':
        return PaymentProvider.momo;
      case 'vnpay':
        return PaymentProvider.vnpay;
    }

    throw UnsupportedError('PaymentProvider not include any value name $this');
  }
}
