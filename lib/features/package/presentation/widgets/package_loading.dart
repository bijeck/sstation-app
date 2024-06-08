import 'package:flutter/material.dart';

import 'package:sstation/features/package/presentation/widgets/package_loading_card.dart';

class PackageLoading extends StatelessWidget {
  const PackageLoading({
    super.key,
    required this.init,
  });
  final int init;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemBuilder: (c, i) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: PackageLoadingCard(),
      ),
      itemCount: init,
    );
  }
}
