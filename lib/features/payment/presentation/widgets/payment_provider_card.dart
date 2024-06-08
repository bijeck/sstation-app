import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/payment.dart';

import 'package:sstation/core/res/colours.dart';

class PaymentProviderCard extends StatelessWidget {
  const PaymentProviderCard({
    super.key,
    required this.provider,
    required this.selectedProvider,
  });
  final PaymentProvider provider;
  final PaymentProvider selectedProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: provider == selectedProvider
            ? Colours.moneyColour.withOpacity(0.2)
            : Colors.white,
        border: Border.all(
          color: provider == selectedProvider
              ? Colors.amber
              : Colours.staticColour,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Radio<int>(
            activeColor: Colours.moneyColour,
            value: provider.index,
            groupValue: selectedProvider.index,
            onChanged: (value) {},
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/${provider.name}.png',
              height: 35,
            ),
          ),
          const SizedBox(width: 10),
          BaseText(
            value: '${provider.name}Wallet'.tr(),
            color: Colors.black,
            size: 18,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
