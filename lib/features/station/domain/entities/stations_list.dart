import 'package:sstation/features/station/domain/entities/station.dart';

class StationsList {
  final List<Station> stations;
  final bool reachMax;
  final int currentPage;
  StationsList({
    required this.stations,
    required this.reachMax,
    required this.currentPage,
  });

  StationsList.reset()
      : stations = [],
        reachMax = false,
        currentPage = 1;

  StationsList copyWith({
    List<Station>? stations,
    bool? reachMax,
    int? currentPage,
  }) {
    return StationsList(
      stations: stations ?? this.stations,
      reachMax: reachMax ?? this.reachMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
