import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/errors/failure.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/package/data/datasources/package_datasource.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/domain/entities/packages_list.dart';
import 'package:sstation/features/package/domain/repos/package_repo.dart';

@LazySingleton(as: PackageRepo)
class PackageRepoImpl extends PackageRepo {
  final PackageDatasource _datasource;

  PackageRepoImpl(this._datasource);

  @override
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
  }) async {
    try {
      final result = await _datasource.getPackagesList(
        name: name,
        status: status,
        type: type,
        from: from,
        to: to,
        pageIndex: pageIndex,
        pageSize: pageSize,
        sortColumn: sortColumn,
        sortDir: sortDir,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<Package> getPackage({
    required String? id,
    required Package? package,
  }) async {
    try {
      if (package != null) {
        return Right(package);
      } else {
        final result = await _datasource.getPackage(
          id: id!,
        );
        return Right(result);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> payPackage({
    required String id,
    required double totalPrice,
  }) async {
    try {
      await _datasource.payPackage(
        id: id,
        totalPrice: totalPrice,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> cancelPackage({
    required String id,
    required String reason,
  }) async {
    try {
      await _datasource.cancelPackage(
        id: id,
        reason: reason,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
