// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';

class ConfirmPaymentForm extends StatefulWidget {
  const ConfirmPaymentForm({
    super.key,
    required this.onCancel,
    required this.onSuccess,
  });
  final VoidCallback onCancel;
  final VoidCallback onSuccess;

  @override
  State<ConfirmPaymentForm> createState() => _ConfirmPaymentFormState();
}

class _ConfirmPaymentFormState extends State<ConfirmPaymentForm> {
  var isConfirm = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colours.backgroundColour,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText(
            value: 'confirmPayment'.tr(),
            size: 20,
            weight: FontWeight.w500,
            color: Colours.primaryColour,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(image: AssetImage(MediaRes.payment)),
            ),
            width: 150,
            height: 150,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            width: context.width * 0.8,
            child: BaseText(
              maxLine: 4,
              value: 'paymentRequired'.tr(),
              size: 12,
              weight: FontWeight.w500,
              color: Colours.primaryTextColour,
            ),
          ),
          SizedBox(
            width: context.width * 0.8,
            child: Row(
              children: [
                Checkbox(
                  focusColor: Colours.primaryColour,
                  activeColor: Colours.primaryColour,
                  value: isConfirm,
                  onChanged: (selected) {
                    setState(() {
                      isConfirm = selected!;
                    });
                  },
                ),
                BaseText(
                  value: 'iAgree'.tr(),
                  color: isConfirm ? Colours.primaryColour : Colors.grey,
                  size: 15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: context.width * 0.3,
                  child: RoundedButton(
                    radius: 15,
                    buttonColour: Colours.highStaticColour,
                    label: BaseText(
                      value: 'cancel'.tr(),
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: widget.onCancel,
                  ),
                ),
                SizedBox(
                  width: context.width * 0.3,
                  child: RoundedButton(
                    canPress: isConfirm,
                    buttonColour:
                        isConfirm ? Colours.successColour : Colors.grey,
                    radius: 15,
                    label: BaseText(
                      value: 'confirm'.tr(),
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: widget.onSuccess,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
