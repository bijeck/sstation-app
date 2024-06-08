import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/domain/repos/notification_repo.dart';

@LazySingleton()
class DeleteNotifications extends UsecaseWithParams<void, List<int>> {
  final NotificationRepo _repo;

  DeleteNotifications(this._repo);

  @override
  ResultFuture<void> call(List<int> param) => _repo.deleteNotifications(ids: param);
}