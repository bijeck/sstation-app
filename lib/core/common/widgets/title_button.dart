import 'package:flutter/material.dart';

import 'package:sstation/core/common/widgets/text_base.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({
    super.key,
    required this.title,
    required this.buttonColour,
    required this.titleColour,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;
  final Color buttonColour;
  final Color titleColour;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: buttonColour,
            ),
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                onPressed();
              },
              child: icon,
            ),
          ),
          BaseText(
            value: title,
            color: titleColour,
            size: 11,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
