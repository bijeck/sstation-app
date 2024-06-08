import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/presentation/bloc/package_bloc.dart';

class PackagesListView<t> extends StatefulWidget {
  final Function() loadMore;
  final Function() onRefresh;
  final Widget initialLoading;
  final Widget initialEmpty;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  const PackagesListView({
    super.key,
    required this.loadMore,
    required this.onRefresh,
    required this.initialLoading,
    required this.initialEmpty,
    this.onLoadMoreError,
    this.onLoadMoreLoading,
    required this.child,
  });

  @override
  State<PackagesListView<t>> createState() => _PackagesListViewState<t>();
}

class _PackagesListViewState<t> extends State<PackagesListView<t>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        if (state is PackagesListLoaded) {
          List<Package> packages = state.packages.packages;
          return NotificationListener<ScrollEndNotification>(
              onNotification: (scrollInfo) {
                scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        !state.packages.reachMax
                    ? widget.loadMore()
                    : null;
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RefreshIndicator(
                  onRefresh: () async => widget.onRefresh(),
                  child: ListView.builder(
                    itemCount: packages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == packages.length &&
                          !state.packages.reachMax) {
                        //showing loader at the bottom of list
                        return widget.onLoadMoreLoading ??
                            const SizedBox.shrink();
                      }

                      if (index == packages.length && state.packages.reachMax) {
                        return const SizedBox.shrink();
                      }
                      return widget.child(packages[index] as t);
                    },
                  ),
                ),
              ));
        }
        if (state is PackagesLoading) {
          return widget.initialLoading;
        }
        if (state is PackagesError) {
          return Center(
            child: BaseText(
              value: state.message,
              size: 15,
            ),
          );
        }
        if (state is PackagesEmpty) {
          return widget.initialEmpty;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
