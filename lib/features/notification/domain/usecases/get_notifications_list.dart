// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';
import 'package:sstation/features/notification/domain/repos/notification_repo.dart';

@LazySingleton()
class GetNotificationsList
    extends UsecaseWithParams<NotificationsList, GetNotificationsListParams> {
  final NotificationRepo _repo;

  GetNotificationsList(this._repo);

  @override
  ResultFuture<NotificationsList> call(GetNotificationsListParams param) =>
      _repo.getNotificationsList(
        search: param.search,
        from: param.from,
        to: param.to,
        pageIndex: param.pageIndex,
        pageSize: param.pageSize,
        isRead: param.isRead,
        sortColumn: param.sortColumn,
        sortDir: param.sortDir,
      );
}

class GetNotificationsListParams extends Equatable {
  const GetNotificationsListParams({
    this.search,
    this.from,
    this.to,
    required this.pageIndex,
    required this.pageSize,
    this.isRead,
    this.sortColumn,
    this.sortDir,
  });

  final String? search;
  final String? from;
  final String? to;
  final int pageIndex;
  final int pageSize;
  final bool? isRead;
  final String? sortColumn;
  final SortDirection? sortDir;

  @override
  List<String> get props => [];
}
