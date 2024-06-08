import 'package:flutter/material.dart';
import 'package:sstation/features/station/presentation/widgets/station_loading_card.dart';

class StationLoading extends StatelessWidget {
  const StationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemBuilder: (c, i) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: StationLoadingCard(),
      ),
      itemCount: 3,
    );
  }
}
