import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/services/injections/injections.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}
