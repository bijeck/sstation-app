// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';

class FieldView extends StatelessWidget {
  const FieldView({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(
            value: '$title:',
            weight: FontWeight.w500,
            color: Colours.highStaticColour,
          ),
          BaseText(
            value: value,
            weight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
