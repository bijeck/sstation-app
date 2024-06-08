import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/errors/failure.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/station/data/datasources/station_datasource.dart';
import 'package:sstation/features/station/domain/entities/stations_list.dart';
import 'package:sstation/features/station/domain/repos/station_repo.dart';


@LazySingleton(as: StationRepo)
class StationRepoImpl extends StationRepo {
  final StationDataSource _datasource;

  StationRepoImpl(this._datasource);

  @override
  ResultFuture<StationsList> fetchStation({
    required String? search,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  }) async {
    try {
      final result = await _datasource.fetchStations(
        search: search,
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
}
