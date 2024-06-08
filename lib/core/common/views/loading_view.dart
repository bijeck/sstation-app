import 'package:flutter/material.dart';
import 'package:sstation/core/res/colours.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colours.primaryColour,
          ),
        ),
      ),
    );
  }
}
