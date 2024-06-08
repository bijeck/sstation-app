import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/main_bottom_navigation_bar.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/price.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:sstation/features/payment/presentation/views/result_screen.dart';
import 'package:sstation/features/payment/presentation/widgets/payment_provider_card.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  static const String routeName = 'deposit';

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  int _selectPriceIndex = 0;
  var _selectedProvider = PaymentProvider.momo;

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (context.height - kToolbarHeight - 200) / 4;
    final double itemWidth = context.width / 2;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: BaseText(
            value: 'depositTitle'.tr(),
            weight: FontWeight.w600,
            size: 25,
          ),
        ),
        body: AppBackground(
          child: BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentError) {
                AppNavigator.pauseAndPushScreen(
                  context: context,
                  routname: ResultScreen.routeName,
                  delayTime: 0,
                  arguments: {'isSuccess': 'false'},
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage(MediaRes.wallet),
                      ),
                    ),
                    width: 150,
                    height: 150,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: itemHeight * 1.3,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: depositPrice.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectPriceIndex = index;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == _selectPriceIndex
                                  ? Colours.moneyColour.withOpacity(0.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: index == _selectPriceIndex
                                    ? Colors.amber
                                    : Colours.staticColour,
                                width: 1,
                              ),
                            ),
                            child: BaseText(
                              value: CoreUtils.oCcy
                                  .format(depositPrice[index])
                                  .toString(),
                              color: Colours.moneyColour,
                              weight: FontWeight.w500,
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                  })
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: MainButtonNavigationBar(
          label: 'deposit'.tr(),
          func: () {
            AppDialog.showConfirm(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(MediaRes.money)),
                    ),
                    width: 150,
                    height: 150,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        value: '${'depositAmount'.tr()} ',
                        size: 20,
                        weight: FontWeight.w500,
                        color: Colours.primaryTextColour,
                      ),
                      BaseText(
                        value:
                            '${CoreUtils.oCcy.format(depositPrice[_selectPriceIndex]).toString()} VND',
                        size: 20,
                        weight: FontWeight.w500,
                        color: Colours.successColour,
                      ),
                    ],
                  )
                ],
              ),
              onCancel: () => SmartDialog.dismiss(),
              onSuccess: () {
                context.read<PaymentBloc>().add(
                      DepositEvent(
                        money: depositPrice[_selectPriceIndex],
                        provider: _selectedProvider,
                      ),
                    );
              },
            );
          },
          backgroundColor: Colors.white,
          buttonColor: Colours.moneyColour,
          lableColor: Colors.white,
        ));
  }
}
