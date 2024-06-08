// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/fonts.dart';

class BaseText extends StatelessWidget {
  const BaseText({
    super.key,
    required this.value,
    this.weight,
    this.size,
    this.color,
    this.overflow,
    this.maxLine,
    this.textAlign,
  });
  final String value;
  final FontWeight? weight;
  final double? size;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: textAlign,
      maxLines: maxLine,
      style: TextStyle(
        overflow: overflow ?? TextOverflow.ellipsis,
        color: color ?? Colours.primaryTextColour,
        fontWeight: weight,
        fontSize: size,
        fontFamily: Fonts.base,
      ),
    );
  }
}
