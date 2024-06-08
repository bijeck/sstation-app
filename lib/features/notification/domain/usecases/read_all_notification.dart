import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/domain/repos/notification_repo.dart';

@LazySingleton()
class ReadAllNotifications extends UsecaseWithoutParams<void> {
  final NotificationRepo _repo;

  ReadAllNotifications(this._repo);

  @override
  ResultFuture<void> call() => _repo.readAllNotifications();
}
