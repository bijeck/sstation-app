import 'package:sstation/features/notification/domain/entities/notification.dart';

class NotificationsList {
  final List<Notification> notifications;
  final bool reachMax;
  final int currentPage;
  final int countUnread;
  NotificationsList({
    required this.notifications,
    required this.reachMax,
    required this.currentPage,
    required this.countUnread,
  });

  NotificationsList.reset()
      : notifications = [],
        reachMax = false,
        currentPage = 1,
        countUnread = 0;

  NotificationsList copyWith({
    List<Notification>? notifications,
    bool? reachMax,
    int? currentPage,
    int? countUnread,
  }) {
    return NotificationsList(
      notifications: notifications ?? this.notifications,
      reachMax: reachMax ?? this.reachMax,
      currentPage: currentPage ?? this.currentPage,
      countUnread: countUnread ?? this.countUnread,
    );
  }
}
