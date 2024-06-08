import 'package:sstation/core/enums/notification.dart';
import 'package:sstation/core/res/media_res.dart';

extension NotificationTypeExt on NotificationType {
  String get image {
    switch (this) {
      case NotificationType.verificationCode:
        return MediaRes.logo;
      case NotificationType.systemStaffCreated:
        return MediaRes.logo;
      case NotificationType.customerPackageCreated:
        return MediaRes.packageBill;
      case NotificationType.customerPaymentPackage:
        return MediaRes.packageList;
      case NotificationType.customerPackageCanceled:
        return MediaRes.logo;
      default:
        return MediaRes.logo;
    }
  }
}
