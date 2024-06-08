import 'package:flutter/material.dart';
import 'package:sstation/features/notification/presentation/widgets/notification_loading_card.dart';

class NotificationLoading extends StatelessWidget {
  const NotificationLoading({super.key, required this.initLoad});
  final int initLoad;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (c, i) => Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: const NotificationLoadingCard(),
        ),
        itemCount: initLoad,
      ),
    );
  }
}
