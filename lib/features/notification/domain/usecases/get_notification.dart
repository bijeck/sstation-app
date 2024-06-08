

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart';
import 'package:sstation/features/notification/domain/repos/notification_repo.dart';

@LazySingleton()
class GetNotification extends UsecaseWithParams<Notification, GetNotificationParams> {
  final NotificationRepo _repo;

  GetNotification(this._repo);

  @override
  ResultFuture<Notification> call(GetNotificationParams param) => _repo.getNotification(
        id: param.id,
        notification: param.notification,
      );
}

class GetNotificationParams extends Equatable {
  const GetNotificationParams({
    this.id,
    this.notification,
  });
  final String? id;
  final Notification? notification;

  @override
  List<Object?> get props => [];
}
