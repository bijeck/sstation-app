import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/errors/failure.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/data/datasources/notification_datasource.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';
import 'package:sstation/features/notification/domain/repos/notification_repo.dart';

@LazySingleton(as: NotificationRepo)
class NotificationRepoImpl extends NotificationRepo {
  final NotificationDatasource _datasource;

  NotificationRepoImpl(this._datasource);

  @override
  ResultFuture<Notification> getNotification({
    required String? id,
    required Notification? notification,
  }) async {
    try {
      if (notification != null) {
        return Right(notification);
      } else {
        final result = await _datasource.getNotification(
          id: id!,
        );
        return Right(result);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<NotificationsList> getNotificationsList({
    required String? search,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required bool? isRead,
    required String? sortColumn,
    required SortDirection? sortDir,
  }) async {
    try {
      final result = await _datasource.getNotificationsList(
        search: search,
        from: from,
        to: to,
        pageIndex: pageIndex,
        pageSize: pageSize,
        isRead: isRead,
        sortColumn: sortColumn,
        sortDir: sortDir,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> readNotification({required int id}) async {
    try {
      await _datasource.readNotification(
        id: id,
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
  
  @override
  ResultFuture<void> readAllNotifications() async{
    try {
      await _datasource.readAllNotifications();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
  
  @override
  ResultFuture<void> deleteNotifications({required List<int> ids}) async{
    try {
      await _datasource.deleteNotifications(ids: ids);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
