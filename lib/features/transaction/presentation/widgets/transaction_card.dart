import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/transaction_method.extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';

import 'package:sstation/features/transaction/domain/entities/transaction.dart';
import 'package:sstation/features/transaction/presentation/views/transaction_details_screen.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 30),
      padding: const EdgeInsets.all(5.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            AppNavigator.pauseAndPushScreen(
              context: context,
              routname: TransactionDetailsScreen.routeName,
              delayTime: 0,
              extra: transaction,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(transaction.method.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BaseText(
                            value: transaction.type.name.tr(),
                            weight: FontWeight.w600,
                            size: 15,
                          ),
                          BaseText(
                            value:
                                '${CoreUtils.oCcy.format(transaction.amount)} VND',
                            size: 13,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: BaseText(
                              value: CoreUtils.parseTimestamp(
                                  transaction.createdAt),
                              size: 10,
                              color: Colours.highStaticColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}
