import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/field_view.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/utils/core_utils.dart';

import 'package:sstation/features/transaction/domain/entities/transaction.dart';

class TransactionDetailsContainer extends StatelessWidget {
  const TransactionDetailsContainer({
    super.key,
    required this.transaction,
  });
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          width: context.width,
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          )),
          child: BaseText(
            value: 'paymentDetailsTitle'.tr(),
            weight: FontWeight.w700,
            size: 20,
          ),
        ),
        const SizedBox(height: 5),
        FieldView(
          title: 'createdDate'.tr(),
          value: CoreUtils.parseTimestamp(transaction.createdAt),
        ),
        const SizedBox(height: 10),
        FieldView(
          title: 'type'.tr(),
          value: transaction.type.name.tr(),
        ),
        const SizedBox(height: 10),
        FieldView(
          title: 'description'.tr(),
          value: transaction.description,
        ),
        const SizedBox(height: 10),
        FieldView(
          title: 'status'.tr(),
          value: transaction.status.name.tr(),
        ),
      ],
    );
  }
}
