// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';

import 'package:sstation/features/package/domain/entities/package_status_history.dart';
import 'package:sstation/features/package/presentation/widgets/pakage_status_view.dart';

class PackageStatusViewContainer extends StatelessWidget {
  const PackageStatusViewContainer({
    super.key,
    required this.packageStatusHistories,
  });

  final List<PackageStatusHistory> packageStatusHistories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          width: context.width,
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          )),
          child: BaseText(
            value: 'status'.tr(),
            weight: FontWeight.w700,
            size: 20,
          ),
        ),
        LimitedBox(
          maxHeight: 400,
          child: PackageStatusView(
            packageStatusHistories: packageStatusHistories,
          ),
        ),
      ],
    );
  }
}
