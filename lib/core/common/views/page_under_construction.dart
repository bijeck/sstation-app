import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/res/media_res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Center(child: Lottie.asset(MediaRes.pageUnderConstruction)),
          ),
        ),
      ),
    );
  }
}
