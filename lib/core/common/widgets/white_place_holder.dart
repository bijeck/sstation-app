import 'package:flutter/material.dart';

class WhitePlaceHolder extends StatelessWidget {
  const WhitePlaceHolder({super.key, required this.child, this.padding = 20, this.alignment});
  final Widget child;
  final double padding;
  final Alignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: child,
    );
  }
}
