import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/station/domain/entities/stations_list.dart';
import 'package:sstation/features/station/domain/usecase/fetch_stations.dart';

part 'station_event.dart';
part 'station_state.dart';

@Injectable()
class StationBloc extends Bloc<StationEvent, StationState> {
  StationsList stations = StationsList(
    stations: [],
    currentPage: 1,
    reachMax: false,
  );
  StationBloc(
    FetchStations fetchStations,
  )   : _fetchStations = fetchStations,
        super(StationInitial()) {
    // on<PackageEvent>((event, emit) {
    //   emit(StationsLoading());
    // });
    on<StationsLoadMoreEvent>(_loadMoreHandler);
    on<FetchStationsEvent>(_fetchStationsHandler);
  }

  final FetchStations _fetchStations;

  Future<void> _loadMoreHandler(
    StationsLoadMoreEvent event,
    Emitter<StationState> emit,
  ) async {
    // return if no stations to load
    if (stations.reachMax) return;
    bool isInitial = stations.currentPage == 1;
    if (isInitial) {
      emit(StationsLoading());
    }
    final result = await _fetchStations(FetchStationsParams(
      search: event.search,
      pageIndex: isInitial ? 1 : stations.currentPage,
      pageSize: 3,
    ));
    result
        .fold((failure) => emit(StationsError(message: AppMessage.serverError)),
            (loadedStations) {
      if (loadedStations.stations.isEmpty) {
        stations = StationsList(
            stations: stations.stations + loadedStations.stations,
            currentPage: stations.currentPage,
            reachMax: loadedStations.reachMax);
        emit(StationsLoaded(stations: stations));
      } else {
        //Adding products to existing list
        stations = StationsList(
            stations: stations.stations + loadedStations.stations,
            currentPage: stations.currentPage + 1,
            reachMax: loadedStations.reachMax);
        emit(StationsLoaded(stations: stations));
      }
    });
  }

  Future<void> _fetchStationsHandler(
    FetchStationsEvent event,
    Emitter<StationState> emit,
  ) async {
    bool isInitial = true;
    stations = StationsList.reset();
    if (isInitial) {
      emit(StationsLoading());
    }
    final result = await _fetchStations(FetchStationsParams(
      search: event.search,
      pageIndex: 1,
      pageSize: 3,
    ));
    result
        .fold((failure) => emit(StationsError(message: AppMessage.serverError)),
            (loadedStations) {
      if (loadedStations.stations.isEmpty) {
        emit(StationsEmpty());
      } else {
        stations = StationsList(
            stations: loadedStations.stations,
            currentPage: stations.currentPage + 1,
            reachMax: loadedStations.reachMax);
        emit(StationsLoaded(stations: stations));
      }
    });
  }
}
