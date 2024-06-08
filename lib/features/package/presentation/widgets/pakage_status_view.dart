import 'package:flutter/material.dart';

import 'package:sstation/features/package/domain/entities/package_status_history.dart';
import 'package:sstation/features/package/presentation/widgets/package_status_timeline.dart';

class PackageStatusView extends StatelessWidget {
  const PackageStatusView({
    super.key,
    required this.packageStatusHistories,
  });

  final List<PackageStatusHistory> packageStatusHistories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return PackageStatusTimeline(
          isFirst: i == 0,
          isLast: i == packageStatusHistories.length - 1,
          statusHistory: packageStatusHistories[i],
        );
      },
      itemCount: packageStatusHistories.length,
    );
  }
}
