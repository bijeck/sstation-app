part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends NotificationEvent {
  const GetNotificationEvent({
    this.id,
    this.notification,
  });
  final String? id;
  final Notification? notification;
}

class GetNotificationsListEvent extends NotificationEvent {
  final String? search;
  final String? from;
  final String? to;
  final bool? isRead;
  const GetNotificationsListEvent({
    this.search,
    this.from,
    this.to,
    this.isRead,
  });
}

class NotificationsLoadMoreEvent extends NotificationEvent {
  final String? search;
  final String? from;
  final String? to;
  final bool? isRead;
  const NotificationsLoadMoreEvent({
    this.search,
    this.from,
    this.to,
    this.isRead,
  });
}

class ReadNotificationEvent extends NotificationEvent {
  final int id;
  const ReadNotificationEvent({
    required this.id,
  });
}

class ReadAllNotificationEvent extends NotificationEvent {
  const ReadAllNotificationEvent();
}

class DeleteNotificationsEvent extends NotificationEvent {
  final List<int> ids;
  const DeleteNotificationsEvent({required this.ids});
}
