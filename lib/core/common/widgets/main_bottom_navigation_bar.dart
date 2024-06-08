import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';

class MainButtonNavigationBar extends StatelessWidget {
  const MainButtonNavigationBar({
    super.key,
    required this.label,
    required this.func,
    this.buttonColor,
    this.lableColor,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback func;
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: RoundedButton(
        radius: 15,
        label: BaseText(
          color: lableColor ?? Colors.white,
          value: label,
          size: 25,
        ),
        onPressed: func,
        buttonColour: buttonColor ?? Colours.moneyColour,
      ),
    );
  }
}
