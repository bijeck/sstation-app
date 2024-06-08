// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';

import 'package:sstation/features/package/domain/entities/package_status_history.dart';

class PackageEventCard extends StatelessWidget {
  const PackageEventCard({
    super.key,
    required this.statusDetail,
  });

  final PackageStatusHistory statusDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            value: statusDetail.status.name.tr(),
            weight: FontWeight.w700,
            color: [PackageStatus.canceled, PackageStatus.returned]
                    .contains(statusDetail.status)
                ? Colors.red
                : Colours.successColour,
          ),
          BaseText(
            value: CoreUtils.parseTimestamp(statusDetail.createdAt),
            weight: FontWeight.w700,
            color: Colours.highStaticColour,
          ),
          if (statusDetail.description.isNotEmpty)
            BaseText(
              value: statusDetail.description,
              weight: FontWeight.w700,
              color: Colours.highStaticColour,
            ),
        ],
      ),
    );
  }
}
