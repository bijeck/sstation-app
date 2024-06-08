import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sstation/core/common/widgets/date_picker.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/res/colours.dart';

class TransactionFilter extends StatelessWidget {
  const TransactionFilter({
    super.key,
    required this.onSelectType,
    required this.onSelectDate,
    required this.onClear,
    required this.onSubmit,
    this.selectedTransactionType,
    this.selectedFrom,
    this.selectedTo,
  });

  final Function(TransactionType?) onSelectType;
  final Function(DateTimeRange) onSelectDate;
  final VoidCallback onClear;
  final VoidCallback onSubmit;

  final TransactionType? selectedTransactionType;
  final String? selectedFrom;
  final String? selectedTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      // margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colours.backgroundColour,
        boxShadow: [
          BoxShadow(
            color: Colours.highStaticColour.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: TransactionType.values
                  .map((type) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: FilterChip(
                          side: BorderSide(
                            color: Colours.highStaticColour.withOpacity(0.15),
                          ),
                          backgroundColor: Colours.backgroundColour,
                          selectedColor: Colours.sentPackageColour,
                          label: BaseText(
                            value: type.name.tr(),
                            color: Colours.primaryTextColour,
                            size: 15,
                          ),
                          selected: selectedTransactionType != null
                              ? type == selectedTransactionType
                              : false,
                          onSelected: (selected) {
                            late TransactionType? selectedType;
                            if (selected) {
                              selectedType = type;
                            } else {
                              selectedType = null;
                            }
                            onSelectType(selectedType);
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          DatePicker(
            from: selectedFrom,
            to: selectedTo,
            onDateSelected: onSelectDate,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    radius: 10,
                    onPressed: onClear,
                    label: BaseText(
                      value: 'clear'.tr(),
                      color: Colors.white,
                      size: 18,
                    ),
                    buttonColour: Colours.highStaticColour,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: RoundedButton(
                    radius: 10,
                    onPressed: onSubmit,
                    label: BaseText(
                      value: 'search'.tr(),
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
