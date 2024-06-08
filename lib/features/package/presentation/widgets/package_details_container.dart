// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/field_view.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/utils/core_utils.dart';

import 'package:sstation/features/package/domain/entities/package.dart';

class PackageDetailsContainer extends StatelessWidget {
  const PackageDetailsContainer({
    super.key,
    required this.package,
  });

  final Package package;

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
            value: package.name,
            weight: FontWeight.w700,
            size: 20,
          ),
        ),
        const SizedBox(height: 5),
        FieldView(
          title: 'sentPerson'.tr(),
          value: package.sender.fullName.isNotEmpty
              ? package.sender.fullName
              : 'User',
        ),
        FieldView(
          title: 'receivePerson'.tr(),
          value: package.receiver.fullName.isNotEmpty
              ? package.receiver.fullName
              : 'User',
        ),
        FieldView(
          title: 'sentDate'.tr(),
          value: CoreUtils.parseTimestamp(package.createdAt),
        ),
        FieldView(title: 'weight'.tr(), value: package.weight.toString()),
        FieldView(title: 'height'.tr(), value: package.height.toString()),
        FieldView(title: 'length'.tr(), value: package.length.toString()),
        FieldView(title: 'volume'.tr(), value: package.volume.toString()),
      ],
    );
  }
}
