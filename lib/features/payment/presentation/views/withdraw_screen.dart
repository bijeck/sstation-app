import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/text_base.dart';

import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/dashboard/presentation/views/home_page_screen.dart';
import 'package:sstation/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:sstation/features/payment/presentation/views/withdraw_staging_screen.dart';
import 'package:sstation/features/payment/presentation/widgets/withdraw_form.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({
    super.key,
    required this.provider,
  });
  final PaymentProvider provider;
  static const String routeName = 'withdraw';
  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  late LocalUser user;
  var moneyController = TextEditingController();
  var idController = TextEditingController();
  @override
  void initState() {
    user = context.userProvider.user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (isPop) {
        if (!isPop) {
          AppNavigator.pauseAndPushScreen(
            context: context,
            delayTime: 0,
            routname: WithdrawStagingScreen.routeName,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: BaseText(
            value: 'withdraw'.tr(),
            weight: FontWeight.w600,
            size: 25,
          ),
        ),
        body: AppBackground(
          child: BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentError) {
                AppDialog.showMessageDialog(
                    AppDialog.errorMessage(state.message));
              } else if (state is PaymentLoading) {
                AppDialog.showLoadingDialog(message: 'processing'.tr());
              } else if (state is WithdrawSuccess) {
                AppDialog.showMessageDialog(
                    AppDialog.sucessMessage('withDrawSuccess'.tr()));
                AppNavigator.pauseAndPushNewScreenWithoutBack(
                  context: context,
                  routname: HomePage.routeName,
                  delayTime: 2,
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                      top: 40,
                      bottom: 30,
                    ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseText(
                              value: 'yourBalance'.tr(),
                              weight: FontWeight.w500,
                              size: 17,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            BaseText(
                              value:
                                  '${CoreUtils.oCcy.format(user.wallet.balance)} VND',
                              weight: FontWeight.w500,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/${widget.provider.name}.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  WithdrawForm(
                    provider: widget.provider,
                    onSubmit: () {
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
                                  value: '${'withDrawAmount'.tr()} ',
                                  size: 20,
                                  weight: FontWeight.w500,
                                  color: Colours.primaryTextColour,
                                ),
                                BaseText(
                                  value:
                                      '${CoreUtils.oCcy.format(int.parse(moneyController.text.trim())).toString()} VND',
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
                                WithdrawEvent(
                                  money: int.parse(moneyController.text.trim()),
                                  provider: widget.provider,
                                  id: idController.text.trim(),
                                ),
                              );
                        },
                      );
                    },
                    moneyController: moneyController,
                    idController: idController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
