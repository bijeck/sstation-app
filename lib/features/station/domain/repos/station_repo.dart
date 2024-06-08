import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/utils/typedefs.dart';
import 'package:sstation/features/station/domain/entities/stations_list.dart';

abstract class StationRepo {
  const StationRepo();

  ResultFuture<StationsList> fetchStation({
    required String? search,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
}
