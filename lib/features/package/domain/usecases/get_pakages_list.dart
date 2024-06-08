import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/package/domain/entities/packages_list.dart';
import 'package:sstation/features/package/domain/repos/package_repo.dart';

@LazySingleton()
class GetPackagesList
    extends UsecaseWithParams<PackagesList, GetPackagesListParams> {
  final PackageRepo _repo;

  GetPackagesList(this._repo);

  @override
  ResultFuture<PackagesList> call(GetPackagesListParams param) =>
      _repo.getPackagesList(
        name: param.name,
        status: param.status,
        type: param.type,
        from: param.from,
        to: param.to,
        pageIndex: param.pageIndex,
        pageSize: param.pageSize,
        sortColumn: param.sortColumn,
        sortDir: param.sortDir,
      );
}

class GetPackagesListParams extends Equatable {
  const GetPackagesListParams({
    this.name,
    this.status,
    this.type,
    this.from,
    this.to,
    required this.pageIndex,
    required this.pageSize,
    this.sortColumn,
    this.sortDir,
  });

  final String? name;
  final PackageStatus? status;
  final UserType? type;
  final String? from;
  final String? to;
  final int pageIndex;
  final int pageSize;
  final String? sortColumn;
  final SortDirection? sortDir;

  @override
  List<String> get props => [];
}
