part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationsLoading extends NotificationState {}

final class NotificationsEmpty extends NotificationState {}

final class NotificationsError extends NotificationState {
  final String message;
  const NotificationsError({required this.message});
  @override
  List<Object> get props => [message];
}

final class NotificationsListLoaded extends NotificationState {
  final NotificationsList notifications;
  const NotificationsListLoaded({
    required this.notifications,
  });

  @override
  List<Object> get props => [
        notifications.notifications.length,
        notifications.reachMax,
        notifications.currentPage
      ];
}

final class NotificationLoaded extends NotificationState {
  final Notification notification;
  const NotificationLoaded({required this.notification});
}

final class NotificationRead extends NotificationState {
  const NotificationRead();
}

final class AllNotificationRead extends NotificationState {
  const AllNotificationRead();
}
