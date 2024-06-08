import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';

abstract class NotificationRepo {
  ResultFuture<NotificationsList> getNotificationsList({
    required String? search,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required bool? isRead,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
  ResultFuture<Notification> getNotification({
    required String? id,
    required Notification? notification,
  });
  ResultFuture<void> readNotification({required int id});
  ResultFuture<void> readAllNotifications();
  ResultFuture<void> deleteNotifications({required List<int> ids});
}
