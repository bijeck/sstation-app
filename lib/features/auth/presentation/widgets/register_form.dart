import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/i_field.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/utils/validate.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.phoneNumberController,
    required this.formKey,
    required this.buttonTile,
    required this.action,
  });

  final String buttonTile;
  final VoidCallback action;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;

  @override
  State<RegisterForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<RegisterForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            IField(
              overrideValidator: true,
              hintText: 'phoneNumber'.tr(),
              controller: widget.phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enterPhoneNumber'.tr();
                }
                if (!Validate.phoneValidate(value)) {
                  return 'enterPhoneNumber'.tr();
                }
                return null;
              },
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: RoundedButton(
                label: BaseText(
                  value: widget.buttonTile,
                  color: Colors.white,
                  weight: FontWeight.w500,
                  size: 22,
                ),
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    widget.action();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
