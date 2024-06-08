// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/dashboard/presentation/views/home_page_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.isSuccess,
  });
  static const String routeName = 'result';

  final bool isSuccess;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    AppDialog.closeDialog();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.height * 0.2,
              width: context.width * 0.7,
              child: Lottie.asset(
                widget.isSuccess ? MediaRes.paidSuccess : MediaRes.paidFailed,
              ),
            ),
            const SizedBox(height: 20),
            BaseText(
              value: widget.isSuccess
                  ? 'paymentSuccess'.tr()
                  : 'paymentUnsuccess'.tr(),
              size: 25,
              weight: FontWeight.w600,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: context.width * 0.5,
              child: RoundedButton(
                buttonColour:
                    widget.isSuccess ? Colours.successColour : Colors.redAccent,
                label: BaseText(
                  value: 'returnHome'.tr(),
                  size: 20,
                  color: Colors.white,
                  weight: FontWeight.w600,
                ),
                onPressed: () {
                  AppNavigator.pauseAndPushNewScreenWithoutBack(
                    context: context,
                    routname: HomePage.routeName,
                    delayTime: 0,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
