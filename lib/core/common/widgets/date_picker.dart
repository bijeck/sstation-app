// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    this.from,
    this.to,
    required this.onDateSelected,
  });

  final String? from;
  final String? to;
  final Function(DateTimeRange) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            BaseText(
              value: 'from'.tr(),
              size: 15,
              color: Colours.primaryTextColour,
            ),
            InkWell(
              onTap: () {
                AppDialog.showDatePickerDialog(
                  from: from ?? CoreUtils.parseDate(DateTime.now()),
                  to: to ?? CoreUtils.parseDate(DateTime.now()),
                  onDateSelected: onDateSelected,
                );
              },
              child: Container(
                width: context.width * 0.3,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colours.highStaticColour,
                  ),
                ),
                child: BaseText(
                  value: from ?? '--/--/----',
                  size: 15,
                  color: Colours.primaryTextColour,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            BaseText(
              value: 'to'.tr(),
              size: 15,
              color: Colours.primaryTextColour,
            ),
            InkWell(
              onTap: () {
                AppDialog.showDatePickerDialog(
                  from: from ?? CoreUtils.parseDate(DateTime.now()),
                  to: to ?? CoreUtils.parseDate(DateTime.now()),
                  onDateSelected: onDateSelected,
                );
              },
              child: Container(
                width: context.width * 0.3,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colours.highStaticColour,
                  ),
                ),
                child: BaseText(
                  value: to ?? '--/--/----',
                  size: 15,
                  color: Colours.primaryTextColour,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
