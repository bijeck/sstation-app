import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/presentation/bloc/transaction_bloc.dart';

class TransactionsListView<t> extends StatefulWidget {
  final Function() loadMore;
  final Function() onRefresh;
  final Widget initialLoading;
  final Widget initialEmpty;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  const TransactionsListView({
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
  State<TransactionsListView<t>> createState() =>
      _TransactionsListViewState<t>();
}

class _TransactionsListViewState<t> extends State<TransactionsListView<t>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionsListLoaded) {
          List<Transaction> transactions = state.transactions.transactions;
          return NotificationListener<ScrollEndNotification>(
              onNotification: (scrollInfo) {
                scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        !state.transactions.reachMax
                    ? widget.loadMore()
                    : null;
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RefreshIndicator(
                  onRefresh: () async => widget.onRefresh(),
                  child: GroupedListView<Transaction, Transaction>(
                    elements: transactions,
                    order: GroupedListOrder.DESC,
                    groupComparator: (element1, element2) =>
                        CoreUtils.toDateTime(element1.createdAt).compareTo(
                            CoreUtils.toDateTime(element2.createdAt)),
                    groupBy: (element) => element,
                    groupSeparatorBuilder: (element) => Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: BaseText(
                        value:
                            CoreUtils.parseDateFromTimestamp(element.createdAt),
                        weight: FontWeight.w600,
                        size: 17,
                        color: Colors.black,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      if (index.id == transactions.last.id &&
                          !state.transactions.reachMax) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.child(index as t),
                            widget.onLoadMoreLoading ?? const SizedBox.shrink()
                          ],
                        );
                      }
                      return widget.child(index as t);
                    },
                  ),
                ),
              ));
        }
        if (state is TransactionsLoading) {
          return widget.initialLoading;
        }
        if (state is TransactionsError) {
          return Center(
            child: BaseText(
              value: state.message,
              size: 15,
            ),
          );
        }
        if (state is TransactionsEmpty) {
          return widget.initialEmpty;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
