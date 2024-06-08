import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/main_bottom_navigation_bar.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/features/payment/presentation/views/withdraw_screen.dart';
import 'package:sstation/features/payment/presentation/widgets/payment_provider_card.dart';

class WithdrawStagingScreen extends StatefulWidget {
  const WithdrawStagingScreen({super.key});
  static const String routeName = 'withdraw-staging';

  @override
  State<WithdrawStagingScreen> createState() => _WithdrawStagingScreenState();
}

class _WithdrawStagingScreenState extends State<WithdrawStagingScreen> {
  var _selectedProvider = PaymentProvider.momo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'withdraw'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BaseText(
                    value: 'processBy'.tr(),
                    color: Colours.primaryTextColour,
                    weight: FontWeight.w500,
                    size: 15,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...PaymentProvider.values.map<Widget>((provider) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedProvider = provider;
                    });
                  },
                  child: PaymentProviderCard(
                    provider: provider,
                    selectedProvider: _selectedProvider,
                  ),
                );
              }),
            ],
          )),
      bottomNavigationBar: MainButtonNavigationBar(
        label: 'continue'.tr(),
        func: () {
          AppNavigator.pauseAndPushScreen(
            context: context,
            routname: WithdrawScreen.routeName,
            delayTime: 0,
            arguments: {'provider': _selectedProvider.name},
          );
        },
        backgroundColor: Colors.white,
        buttonColor: Colours.moneyColour,
        lableColor: Colors.white,
      ),
    );
  }
}
