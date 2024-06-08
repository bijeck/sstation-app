// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/constants.dart';

class ReasonCancel extends StatefulWidget {
  const ReasonCancel({
    super.key,
    required this.onSelected,
    required this.onConfirm,
  });
  final Function(int) onSelected;
  final VoidCallback onConfirm;

  @override
  State<ReasonCancel> createState() => _ReasonCancelState();
}

class _ReasonCancelState extends State<ReasonCancel> {
  int? selectedReason;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70,
          decoration: BoxDecoration(
            color: Colours.backgroundColour,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BaseText(
          value: 'reasonForCancel'.tr(),
          size: 20,
          weight: FontWeight.w600,
          color: Colors.red,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          itemCount: cancelReasons.length,
          itemBuilder: (_, index) {
            return CheckboxListTile(
              checkColor: Colors.white,
              activeColor: Colours.primaryColour,
              controlAffinity: ListTileControlAffinity.leading,
              value: selectedReason != null && selectedReason == index,
              onChanged: (isSelected) {
                setState(() {
                  selectedReason = isSelected! ? index : null;
                  widget.onSelected(index);
                });
              },
              title: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(bottom: 15, right: 15, top: 15),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: BaseText(
                  value: cancelReasons[index].tr(),
                  size: 15,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: context.width,
          child: RoundedButton(
            canPress: selectedReason != null,
            buttonColour: selectedReason != null ? Colors.red : Colors.grey,
            radius: 30,
            label: BaseText(
              value: 'confirm'.tr(),
              color: Colors.white,
              size: 20,
              weight: FontWeight.bold,
            ),
            onPressed: widget.onConfirm,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
