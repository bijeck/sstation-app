import 'package:flutter/material.dart';
import 'package:sstation/core/res/colours.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: Colours.backgroundColour,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(child: child),
    );
  }
}
