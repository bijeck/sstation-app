import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_card.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_filter.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_list_view.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_loading.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_loading_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  static const routeName = 'user-transactions';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionType? transactionType;
  String? from;
  String? to;
  @override
  void initState() {
    context.read<TransactionBloc>().add(const GetTransactionsListEvent());
    super.initState();
  }

  var isShow = false;

  void _onClear() {
    setState(() {
      from = null;
      to = null;
      transactionType = null;
      context.read<TransactionBloc>().add(const GetTransactionsListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'transactionTitle'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isShow
                  ? Icons.filter_alt_off_outlined
                  : Icons.filter_alt_outlined,
              size: 25,
              color: Colours.primaryTextColour,
            ),
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isShow,
            child: TransactionFilter(
              onClear: _onClear,
              onSelectDate: (value) => setState(() {
                from = CoreUtils.parseDate(value.start);
                to = CoreUtils.parseDate(value.end);
              }),
              onSelectType: (type) {
                setState(() {
                  transactionType = type;
                });
              },
              onSubmit: () {
                context.read<TransactionBloc>().add(
                      GetTransactionsListEvent(
                        type: transactionType,
                        from: from,
                        to: to,
                      ),
                    );
              },
              selectedFrom: from,
              selectedTo: to,
              selectedTransactionType: transactionType,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TransactionsListView<Transaction>(
              onRefresh: _onClear,
              loadMore: () {
                context.read<TransactionBloc>().add(
                      TransactionsLoadMoreEvent(
                        type: transactionType,
                        from: from,
                        to: to,
                      ),
                    );
              },
              initialEmpty: Center(
                child: BaseText(
                  value: 'emptyTransaction'.tr(),
                  size: 15,
                ),
              ),
              initialLoading: const TransactionLoading(initLoad: 8),
              onLoadMoreLoading: const TransactionLoadingCard(),
              child: (Transaction transaction) {
                return TransactionCard(transaction: transaction);
              },
            ),
          ),
        ],
      ),
    );
  }
}
