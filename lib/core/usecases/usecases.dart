import 'package:sstation/core/utils/typedefs.dart';

abstract class UsecaseWithParams<T, Params> {
  const UsecaseWithParams();
  ResultFuture<T> call(Params param);
}

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();
  ResultFuture<T> call();
}
