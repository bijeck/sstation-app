// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sstation/core/common/widgets/i_field.dart';
import 'package:sstation/core/utils/validate.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IField(
          overrideValidator: true,
          hintText: 'password'.tr(),
          controller: widget.passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'enterPassword'.tr();
            }
            if (!Validate.passwordValidate(value)) {
              return 'passwordValidate'.tr();
            }
            return null;
          },
          obscureText: obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              obscurePassword = !obscurePassword;
            }),
            icon: Icon(
              obscurePassword ? IconlyLight.show : IconlyLight.hide,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 25),
        IField(
          hintText: 'confirmPassword'.tr(),
          controller: widget.confirmPasswordController,
          validator: (value) {
            if (value == null ||
                value.compareTo(widget.passwordController.text.trim()) != 0) {
              return 'confirmPasswordValidate'.tr();
            }
            return null;
          },
          obscureText: obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              obscurePassword = !obscurePassword;
            }),
            icon: Icon(
              obscurePassword ? IconlyLight.show : IconlyLight.hide,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
