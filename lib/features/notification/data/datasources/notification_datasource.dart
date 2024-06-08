import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/extensions/map_extension.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:sstation/features/notification/data/entities/notification_model.dart';
import 'package:sstation/features/notification/data/entities/notifications_list_model.dart';

abstract class NotificationDatasource {
  const NotificationDatasource();

  Future<NotificationsListModel> getNotificationsList({
    required String? search,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required bool? isRead,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
  Future<NotificationModel> getNotification({
    required String id,
  });
  Future<void> readNotification({
    required int id,
  });
  Future<void> readAllNotifications();
  Future<void> deleteNotifications({
    required List<int> ids,
  });
}

@LazySingleton(as: NotificationDatasource)
class NotificationDatasourceImpl extends NotificationDatasource {
  const NotificationDatasourceImpl({
    required HiveInterface hiveAuth,
  }) : _hiveAuth = hiveAuth;

  final HiveInterface _hiveAuth;

  @override
  Future<NotificationModel> getNotification({required String id}) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.get(
        url: '${ApiConstants.notificationsEndpoint}/$id',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      NotificationModel notification =
          NotificationModel.fromJson(response.body);
      return notification;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<NotificationsListModel> getNotificationsList({
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
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      Map<String, dynamic> queryParameters = {
        'search': search ?? '',
        'from': from != null ? CoreUtils.reformatDate(from) : '',
        'to': to != null ? CoreUtils.reformatDate(to) : '',
        'pageIndex': pageIndex.toString(),
        'pageSize': pageSize.toString(),
        'isRead': isRead ?? '',
        'sortColumn': sortColumn ?? '',
        'sortDir': sortDir != null ? sortDir.name : '',
      };
      queryParameters.removeWhere((key, value) => value.isEmpty);
      final response = await APIRequest.get(
        url:
            '${ApiConstants.notificationsEndpoint}${queryParameters.toQueryString()}',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      NotificationsListModel list =
          NotificationsListModel.fromJson(response.body);
      return list;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> readNotification({required int id}) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);
      final response = await APIRequest.patch(
        url: '${ApiConstants.notificationsEndpoint}/$id',
        token: userToken.accessToken,
        body: {
          'isRead': true,
        },
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      return;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> readAllNotifications() async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);
      final response = await APIRequest.patch(
        url: '${ApiConstants.notificationsEndpoint}/readAll',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      return;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> deleteNotifications({required List<int> ids}) async{
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);
      final response = await APIRequest.delete(
        url: ApiConstants.notificationsEndpoint,
        token: userToken.accessToken,
        body: {
          'ids': ids,
        },
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      return;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }
}
