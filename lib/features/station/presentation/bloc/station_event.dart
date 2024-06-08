part of 'station_bloc.dart';

sealed class StationEvent extends Equatable {
  const StationEvent();

  @override
  List<Object> get props => [];
}

class FetchStationsEvent extends StationEvent {
  final String? search;
  const FetchStationsEvent({this.search});
}

class StationsLoadEvent extends StationEvent {
  final String? search;
  const StationsLoadEvent({this.search});
}

class StationsLoadMoreEvent extends StationEvent {
  final String? search;
  const StationsLoadMoreEvent({this.search});
}
