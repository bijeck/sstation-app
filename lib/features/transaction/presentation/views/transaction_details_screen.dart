import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/common/widgets/white_place_holder.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_details_container.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({
    super.key,
    this.transaction,
    this.id,
  });

  static const routeName = 'transaction-details';

  final Transaction? transaction;
  final String? id;

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  Transaction? loadedTransaction;
  @override
  void initState() {
    context.read<TransactionBloc>().add(GetTransactionEvent(
          id: widget.id,
          transaction: widget.transaction,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'transactionDetailsTitle'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (_, state) {
              if (state is TransactionLoaded) {
                var isReceive = [
                  TransactionType.deposit,
                  TransactionType.receive
                ].contains(state.transaction.type);
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          BaseText(
                            value: 'amount'.tr(),
                            weight: FontWeight.w600,
                            size: 25,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: isReceive ? '+ ' : '- ',
                                  style: TextStyle(
                                    color: isReceive
                                        ? Colours.successColour
                                        : Colours.primaryTextColour,
                                    fontSize: 30,
                                  ),
                                ),
                                TextSpan(
                                  text: CoreUtils.oCcy
                                      .format(state.transaction.amount),
                                  style: TextStyle(
                                    color: isReceive
                                        ? Colours.successColour
                                        : Colours.primaryTextColour,
                                    fontSize: 30,
                                  ),
                                ),
                                TextSpan(
                                  text: ' VND',
                                  style: TextStyle(
                                    color: isReceive
                                        ? Colours.successColour
                                        : Colours.primaryTextColour,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          WhitePlaceHolder(
                            child: TransactionDetailsContainer(
                              transaction: state.transaction,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (state is TransactionsError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
