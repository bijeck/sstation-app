import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/field_view.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';

import 'package:sstation/features/package/domain/entities/package.dart';

class PackagePaymentDetailsContainer extends StatelessWidget {
  const PackagePaymentDetailsContainer({
    super.key,
    required this.package,
  });
  final Package package;

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
          title: 'totalDateImported'.tr(),
          value: package.totalDays.toString(),
        ),
        FieldView(
          title: 'packagePrice'.tr(),
          value: CoreUtils.oCcy.format(package.priceCod),
        ),
        FieldView(
          title: 'servicePrice'.tr(),
          value: CoreUtils.oCcy.format(package.serviceFee),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          width: context.width,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                value: 'totalPrice'.tr(),
                weight: FontWeight.w500,
                color: Colours.highStaticColour,
              ),
              BaseText(
                value: package.formatTotalPrice,
                weight: FontWeight.w700,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
