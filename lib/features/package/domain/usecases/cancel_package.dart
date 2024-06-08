// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/package/domain/repos/package_repo.dart';

@LazySingleton()
class CancelPackage extends UsecaseWithParams<void, CancelPackageParams> {
  final PackageRepo _repo;

  CancelPackage(this._repo);

  @override
  ResultFuture<void> call(CancelPackageParams param) => _repo.cancelPackage(
        id: param.id,
        reason: param.reason,
      );
}

class CancelPackageParams extends Equatable {
  const CancelPackageParams({
    required this.id,
    required this.reason,
  });
  final String id;
  final String reason;

  @override
  List<Object?> get props => [];
}
