// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/app/navigator.dart';

import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/common/widgets/title_button.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/payment/presentation/views/deposit_screen.dart';
import 'package:sstation/features/payment/presentation/views/withdraw_staging_screen.dart';
import 'package:sstation/features/profile/domain/entities/wallet.dart';

class MoneyViewContainer extends StatefulWidget {
  const MoneyViewContainer({
    super.key,
    required this.wallet,
  });

  final Wallet wallet;

  @override
  State<MoneyViewContainer> createState() => _MoneyViewContainerState();
}

class _MoneyViewContainerState extends State<MoneyViewContainer> {
  bool obscureMoney = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      padding: const EdgeInsets.only(right: 5, left: 5, top: 35, bottom: 5),
      width: context.width - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colours.primaryColour,
              Colours.primaryColour.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: obscureMoney
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                color: Colors.white,
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    obscureMoney = !obscureMoney;
                  });
                },
              ),
              BaseText(
                value: obscureMoney
                    ? '****** VNĐ'
                    : '${CoreUtils.oCcy.format(widget.wallet.balance)} VNĐ',
                color: Colors.white,
                size: 20,
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TitleButton(
                title: 'deposit'.tr(),
                buttonColour: Colours.notactiveButtonColour,
                titleColour: Colors.white,
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: () {
                  AppNavigator.pauseAndPushScreen(
                    context: context,
                    routname: DepositScreen.routeName,
                    delayTime: 0,
                  );
                },
              ),
              TitleButton(
                title: 'withdraw'.tr(),
                buttonColour: Colours.notactiveButtonColour,
                titleColour: Colors.white,
                icon: const Icon(
                  Icons.install_mobile,
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: () {
                  AppNavigator.pauseAndPushScreen(
                    context: context,
                    routname: WithdrawStagingScreen.routeName,
                    delayTime: 0,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
