import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/notification/domain/repos/notification_repo.dart';

@LazySingleton()
class ReadNotification extends UsecaseWithParams<void, int> {
  final NotificationRepo _repo;

  ReadNotification(this._repo);

  @override
  ResultFuture<void> call(int param) => _repo.readNotification(id: param);
}
