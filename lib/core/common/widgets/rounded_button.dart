import 'package:flutter/material.dart';
import 'package:sstation/core/res/colours.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.label,
    required this.onPressed,
    this.radius,
    this.buttonColour,
    this.labelColour,
    this.canPress = true,
    super.key,
  });

  final Widget label;
  final bool canPress;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 20),
        ),
        backgroundColor: buttonColour ?? Colours.primaryColour,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      onPressed: canPress ? onPressed : () {},
      child: label,
    );
  }
}
