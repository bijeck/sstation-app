part of 'station_bloc.dart';

sealed class StationState extends Equatable {
  const StationState();

  @override
  List<Object> get props => [];
}

final class StationInitial extends StationState {}

//State for initial Loading when current page will be 1
final class StationsLoading extends StationState {}

// final class ProductInitialError extends StationState {
//   final String message;
//   const ProductInitialError({required this.message});
// }

final class StationsEmpty extends StationState {}

final class StationsError extends StationState {
  final String message;
  const StationsError({required this.message});
}

final class StationsLoaded extends StationState {
  final StationsList stations;
  const StationsLoaded({
    required this.stations,
  });

  @override
  List<Object> get props =>
      [stations.stations.length, stations.reachMax, stations.currentPage];
}
