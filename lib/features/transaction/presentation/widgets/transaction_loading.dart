import 'package:flutter/material.dart';
import 'package:sstation/features/transaction/presentation/widgets/transaction_loading_card.dart';

class TransactionLoading extends StatelessWidget {
  const TransactionLoading({super.key, required this.initLoad});
  final int initLoad;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemBuilder: (c, i) => Container(
        margin: const EdgeInsets.only(left: 10, right: 20),
        child: const TransactionLoadingCard(),
      ),
      itemCount: initLoad,
    );
  }
}
