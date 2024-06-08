import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/res/colours.dart';

class DoubleMainButtonNavigationBar extends StatelessWidget {
  const DoubleMainButtonNavigationBar({
    super.key,
    required this.label,
    required this.func,
    required this.onCancel,
    this.buttonColor,
    this.lableColor,
    this.backgroundColor,
  });

  final Widget label;
  final VoidCallback func;
  final VoidCallback onCancel;
  final Color? buttonColor;
  final Color? lableColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colours.highStaticColour.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: RoundedButton(
              radius: 15,
              label: label,
              onPressed: func,
              buttonColour: buttonColor ?? Colours.moneyColour,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
                size: 35,
                color: Colours.highStaticColour,
              ),
              onPressed: onCancel,
            ),
          ),
        ],
      ),
    );
  }
}
