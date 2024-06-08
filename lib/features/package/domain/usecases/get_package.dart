// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/domain/repos/package_repo.dart';

@LazySingleton()
class GetPackage extends UsecaseWithParams<Package, GetPackageParams> {
  final PackageRepo _repo;

  GetPackage(this._repo);

  @override
  ResultFuture<Package> call(GetPackageParams param) => _repo.getPackage(
        id: param.id,
        package: param.package,
      );
}

class GetPackageParams extends Equatable {
  const GetPackageParams({
    this.id,
    this.package,
  });
  final String? id;
  final Package? package;

  @override
  List<Object?> get props => [];
}
