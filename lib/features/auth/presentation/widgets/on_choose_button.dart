import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';

class OnChooseButton extends StatelessWidget {
  const OnChooseButton({
    super.key,
    required this.isChoose,
    required this.text,
    required this.func,
  });
  final bool isChoose;
  final String text;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func(),
      child: BaseText(
        value: text,
        color: isChoose ? null : Colours.staticColour,
        size: isChoose ? 25 : 15,
        weight: isChoose ? FontWeight.w600 : FontWeight.w400,
      ),
    );
  }
}
