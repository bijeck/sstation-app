// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:sstation/core/res/colours.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({
    super.key,
    required this.otpController,
    required this.onChanged,
  });
  final OtpFieldController otpController;
  final ValueChanged<String> onChanged;

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  Widget build(BuildContext context) {
    return OTPTextField(
      onChanged: (value) => widget.onChanged(value),
      controller: widget.otpController,
      length: 6,
      width: double.infinity,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colours.staticColour,
        disabledBorderColor: Colours.staticColour,
        enabledBorderColor: Colours.staticColour,
        borderColor: Colours.staticColour,
        focusBorderColor: Colours.primaryColour,
      ),
      fieldWidth: 40,
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: 5,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
