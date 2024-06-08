import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/features/station/domain/entities/station.dart';
import 'package:sstation/features/station/presentation/bloc/station_bloc.dart';
import 'package:sstation/features/station/presentation/widgets/station_loading_card.dart';

class StationsListView<t> extends StatefulWidget {
  final Function() loadMore;
  final Widget initialLoading;
  final Widget initialEmpty;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  const StationsListView({
    super.key,
    required this.loadMore,
    required this.initialLoading,
    required this.initialEmpty,
    this.onLoadMoreError,
    this.onLoadMoreLoading,
    required this.child,
  });

  @override
  State<StationsListView<t>> createState() => _StationsListViewState<t>();
}

class _StationsListViewState<t> extends State<StationsListView<t>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) {
        if (state is StationsLoaded) {
          List<Station> stations = state.stations.stations;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: stations.length + 1,
              itemBuilder: (context, index) {
                if (index == stations.length && !state.stations.reachMax) {
                  //showing loader at the bottom of list
                  return const StationLoadingCard();
                }

                if (index == stations.length && state.stations.reachMax) {
                  return const SizedBox.shrink();
                }
                return widget.child(stations[index] as t);
              },
            ),
          );
        }
        if (state is StationsLoading) {
          return widget.initialLoading;
        }
        if (state is StationsError) {
          return Center(
            child: BaseText(
              value: state.message,
              size: 15,
            ),
          );
        }
        if (state is StationsEmpty) {
          return widget.initialEmpty;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
