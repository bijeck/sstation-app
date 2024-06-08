// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sstation/core/common/widgets/i_field.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/utils/validate.dart';

class WithdrawForm extends StatefulWidget {
  const WithdrawForm({
    super.key,
    required this.provider,
    required this.onSubmit,
    required this.moneyController,
    required this.idController,
  });
  final PaymentProvider provider;
  final VoidCallback onSubmit;
  final TextEditingController moneyController;
  final TextEditingController idController;

  @override
  State<WithdrawForm> createState() => _WithdrawFormState();
}

class _WithdrawFormState extends State<WithdrawForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          IField(
            controller: widget.idController,
            keyboardType: TextInputType.number,
            hintText: widget.provider == PaymentProvider.momo
                ? 'phoneNumber'.tr()
                : 'vnpayAccount'.tr(),
            validator: (value) {
              if (widget.provider == PaymentProvider.momo) {
                if (value == null || value.isEmpty) {
                  return 'enterPhoneNumber'.tr();
                }
                if (!Validate.phoneValidate(value)) {
                  return 'enterPhoneNumber'.tr();
                }
              } else {
                if (value == null || value.isEmpty) {
                  return 'enterVnpayAccount'.tr();
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          IField(
            keyboardType: TextInputType.number,
            controller: widget.moneyController,
            hintText: 'amount'.tr(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: RoundedButton(
              label: BaseText(
                value: 'withDrawAmount'.tr(),
                color: Colors.white,
                weight: FontWeight.w500,
                size: 22,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.onSubmit();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
