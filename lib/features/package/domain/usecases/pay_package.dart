import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/package/domain/repos/package_repo.dart';

@LazySingleton()
class PayPackage extends UsecaseWithParams<void, PayPackageParams> {
  final PackageRepo _repo;

  PayPackage(this._repo);

  @override
  ResultFuture<void> call(PayPackageParams param) => _repo.payPackage(
        id: param.id,
        totalPrice: param.totalPrice,
      );
}

class PayPackageParams extends Equatable {
  const PayPackageParams({
    required this.id,
    required this.totalPrice,
  });
  final String id;
  final double totalPrice;

  @override
  List<Object?> get props => [id, totalPrice];
}
