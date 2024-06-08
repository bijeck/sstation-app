import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';
import 'package:sstation/features/notification/domain/usecases/delete_notifications.dart';
import 'package:sstation/features/notification/domain/usecases/get_notification.dart';
import 'package:sstation/features/notification/domain/usecases/get_notifications_list.dart';
import 'package:sstation/features/notification/domain/usecases/read_all_notification.dart';
import 'package:sstation/features/notification/domain/usecases/read_notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

@Injectable()
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationsList notifications = NotificationsList(
    notifications: [],
    currentPage: 1,
    reachMax: false,
    countUnread: 0,
  );
  NotificationBloc(
    GetNotificationsList getNotificationsList,
    GetNotification getNotification,
    ReadNotification readNotification,
    ReadAllNotifications readAllNotifications,
    DeleteNotifications deleteNotifications,
  )   : _getNotificationsList = getNotificationsList,
        _getNotification = getNotification,
        _readNotification = readNotification,
        _readAllNotifications = readAllNotifications,
        _deleteNotifications = deleteNotifications,
        super(NotificationInitial()) {
    on<NotificationsLoadMoreEvent>(_loadMoreHandler);
    on<GetNotificationsListEvent>(_getNotificationsListHandler);
    on<GetNotificationEvent>(_getNotificationHandler);
    on<ReadNotificationEvent>(_readNotificationHandler);
    on<ReadAllNotificationEvent>(_readAllNotificationsHandler);
    on<DeleteNotificationsEvent>(_deleteNotificationsHandler);
  }

  final GetNotificationsList _getNotificationsList;
  final GetNotification _getNotification;
  final ReadNotification _readNotification;
  final ReadAllNotifications _readAllNotifications;
  final DeleteNotifications _deleteNotifications;

  Future<void> _loadMoreHandler(
    NotificationsLoadMoreEvent event,
    Emitter<NotificationState> emit,
  ) async {
    // logger.d('Load more notifications');
    bool isInitial = notifications.currentPage == 1;
    if (isInitial) {
      emit(NotificationsLoading());
    }
    final result = await _getNotificationsList(GetNotificationsListParams(
      search: event.search,
      from: event.from,
      to: event.to,
      isRead: event.isRead,
      pageIndex: isInitial ? 1 : notifications.currentPage,
      pageSize: 10,
    ));
    result.fold(
        (failure) => emit(NotificationsError(message: AppMessage.serverError)),
        (loadedNotifications) {
      // logger.d('Loaded more ${loadedNotifications.notifications.length}');

      if (loadedNotifications.notifications.isEmpty) {
        notifications = NotificationsList(
            notifications:
                notifications.notifications + loadedNotifications.notifications,
            currentPage: notifications.currentPage,
            countUnread: loadedNotifications.countUnread,
            reachMax: loadedNotifications.reachMax);
        emit(NotificationsListLoaded(notifications: notifications));
      } else {
        //Adding products to existing list
        notifications = NotificationsList(
            notifications:
                notifications.notifications + loadedNotifications.notifications,
            currentPage: notifications.currentPage + 1,
            countUnread: loadedNotifications.countUnread,
            reachMax: loadedNotifications.reachMax);
        emit(NotificationsListLoaded(notifications: notifications));
      }
    });
  }

  Future<void> _getNotificationsListHandler(
    GetNotificationsListEvent event,
    Emitter<NotificationState> emit,
  ) async {
    bool isInitial = true;
    notifications = NotificationsList.reset();
    if (isInitial) {
      emit(NotificationsLoading());
    }
    final result = await _getNotificationsList(GetNotificationsListParams(
      search: event.search,
      pageIndex: 1,
      pageSize: 10,
      from: event.from,
      to: event.to,
      isRead: event.isRead,
    ));
    result.fold(
        (failure) => emit(NotificationsError(message: AppMessage.serverError)),
        (loadedNotifications) {
      if (loadedNotifications.notifications.isEmpty) {
        emit(NotificationsEmpty());
      } else {
        notifications = NotificationsList(
            notifications: loadedNotifications.notifications,
            currentPage: notifications.currentPage + 1,
            countUnread: loadedNotifications.countUnread,
            reachMax: loadedNotifications.reachMax);
        emit(NotificationsListLoaded(notifications: notifications));
      }
    });
  }

  Future<void> _getNotificationHandler(
    GetNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationsLoading());
    final result = await _getNotification(
      GetNotificationParams(
        id: event.id,
        notification: event.notification,
      ),
    );
    result.fold(
      (failure) => emit(NotificationsError(message: AppMessage.serverError)),
      (loadedNotification) =>
          emit(NotificationLoaded(notification: loadedNotification)),
    );
  }

  Future<void> _readNotificationHandler(
    ReadNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _readNotification(event.id);
    result.fold(
      (failure) => emit(NotificationsError(message: AppMessage.serverError)),
      (loadedNotification) =>
          emit(NotificationsListLoaded(notifications: notifications)),
    );
  }

  Future<void> _readAllNotificationsHandler(
    ReadAllNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _readAllNotifications();
    result.fold(
      (failure) => emit(NotificationsError(message: AppMessage.serverError)),
      (loadedNotification) =>
          emit(NotificationsListLoaded(notifications: notifications)),
    );
  }

  Future<void> _deleteNotificationsHandler(
    DeleteNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    notifications.notifications
        .removeWhere((element) => event.ids.contains(element.id));
    emit(NotificationsListLoaded(notifications: notifications));

    final result = await _deleteNotifications(event.ids);
    result.fold(
      (failure) => emit(NotificationsError(message: AppMessage.serverError)),
      (loadedNotification) =>
          emit(NotificationsListLoaded(notifications: notifications)),
    );
  }
}
