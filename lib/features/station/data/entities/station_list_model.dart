import 'dart:convert';

import 'package:sstation/features/station/data/entities/station_model.dart';
import 'package:sstation/features/station/domain/entities/stations_list.dart';

class StationsListModel extends StationsList {
  StationsListModel({
    required super.stations,
    required super.reachMax,
    required super.currentPage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stations': stations.map((x) => (x as StationModel).toMap()).toList(),
      'reachMax': reachMax,
      'currentPage': currentPage,
    };
  }

  factory StationsListModel.fromMap(Map<String, dynamic> map) {
    return StationsListModel(
      stations: List<StationModel>.from(
        (map['contends'] as List<dynamic>).map<StationModel>(
          (x) => StationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      reachMax: !map['hasNextPage'],
      currentPage: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StationsListModel.fromJson(String source) =>
      StationsListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StationsList(station: $stations, reachMax: $reachMax, currentPage: $currentPage)';
}
