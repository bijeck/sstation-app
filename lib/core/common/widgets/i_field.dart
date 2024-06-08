import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';

class IField extends StatelessWidget {
  const IField({
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    required this.hintText,
    super.key,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.keyboardType,
    this.hintStyle,
    this.onChangeFunction,
    this.overrideValidator = false,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final VoidCallback? onChangeFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(value: hintText, size: 15),
        const SizedBox(height: 5),
        TextFormField(
          onChanged: (string) {
            onChangeFunction ?? () {};
          },
          controller: controller,
          validator: overrideValidator
              ? validator
              : (value) {
                  if (value == null || value.isEmpty) {
                    return 'enterValue'.tr();
                  }
                  return validator?.call(value);
                },
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          keyboardType: keyboardType,
          obscureText: obscureText,
          obscuringCharacter: '*',
          readOnly: readOnly,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colours.staticColour),
            ),
            errorMaxLines: 4,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colours.primaryTextColour.withOpacity(0.5),
              ),
            ),
            // overwriting the default padding helps with that puffy look
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            hintStyle: hintStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}
