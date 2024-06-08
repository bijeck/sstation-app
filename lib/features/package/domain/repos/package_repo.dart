import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/domain/entities/packages_list.dart';

abstract class PackageRepo {
  const PackageRepo();

  ResultFuture<PackagesList> getPackagesList({
    required String? name,
    required PackageStatus? status,
    required UserType? type,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
  ResultFuture<Package> getPackage({
    required String? id,
    required Package? package,
  });
  ResultFuture<void> payPackage({
    required String id,
    required double totalPrice,
  });
  ResultFuture<void> cancelPackage({
    required String id,
    required String reason,
  });
}
