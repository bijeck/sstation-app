import 'dart:convert';

import 'package:sstation/features/notification/data/entities/notification_model.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';


class NotificationsListModel extends NotificationsList {
  NotificationsListModel({
    required super.notifications,
    required super.reachMax,
    required super.currentPage,
    required super.countUnread,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notifications': notifications.map((x) => (x as NotificationModel).toMap()).toList(),
      'reachMax': reachMax,
      'currentPage': currentPage,
      'countUnread': countUnread,
    };
  }

  factory NotificationsListModel.fromMap(Map<String, dynamic> map) {
    return NotificationsListModel(
      notifications: List<NotificationModel>.from(
        (map['contends'] as List<dynamic>).map<NotificationModel>(
          (x) => NotificationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      reachMax: !map['hasNextPage'],
      currentPage: map['page'] as int,
      countUnread: map['countUnread'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsListModel.fromJson(String source) =>
      NotificationsListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificationsList(products: $notifications, reachMax: $reachMax, currentPage: $currentPage)';
}
