// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/usecases/usecases.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/station/domain/entities/stations_list.dart';
import 'package:sstation/features/station/domain/repos/station_repo.dart';

@lazySingleton
class FetchStations
    extends UsecaseWithParams<StationsList, FetchStationsParams> {
  final StationRepo _repo;

  FetchStations(this._repo);

  @override
  ResultFuture<StationsList> call(FetchStationsParams param) =>
      _repo.fetchStation(
        search: param.search,
        pageIndex: param.pageIndex,
        pageSize: param.pageSize,
        sortColumn: param.sortColumn,
        sortDir: param.sortDir,
      );
}

class FetchStationsParams extends Equatable {
  const FetchStationsParams({
    this.search,
    required this.pageIndex,
    required this.pageSize,
    this.sortColumn,
    this.sortDir,
  });

  final String? search;
  final int pageIndex;
  final int pageSize;
  final String? sortColumn;
  final SortDirection? sortDir;

  @override
  List<String> get props => [];
}
