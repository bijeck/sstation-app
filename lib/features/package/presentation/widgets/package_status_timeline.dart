import 'package:flutter/material.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/res/colours.dart';

import 'package:sstation/features/package/domain/entities/package_status_history.dart';
import 'package:sstation/features/package/presentation/widgets/package_event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class PackageStatusTimeline extends StatelessWidget {
  const PackageStatusTimeline({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.statusHistory,
  });

  final bool isFirst;
  final bool isLast;
  final PackageStatusHistory statusHistory;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(color: Colours.highStaticColour),
      indicatorStyle: IndicatorStyle(
        color: [PackageStatus.canceled, PackageStatus.returned]
                .contains(statusHistory.status)
            ? Colors.red
            : Colours.successColour,
        width: 30,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: [PackageStatus.canceled, PackageStatus.returned]
                  .contains(statusHistory.status)
              ? Icons.cancel
              : Icons.check_circle,
        ),
      ),
      endChild: PackageEventCard(statusDetail: statusHistory),
    );
  }
}
