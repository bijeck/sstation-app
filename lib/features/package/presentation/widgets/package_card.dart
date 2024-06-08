import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/app/providers/user_provider.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';

import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/extensions/package_status_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/presentation/views/package_details_screen.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.package,
  });

  final Package package;

  Color getPackageColor(String id) {
    if (id == package.sender.id) return Colours.sentPackageColour;
    return Colours.secondaryColour;
  }

  @override
  Widget build(BuildContext context) {
    LocalUser user = context.read<UserProvider>().user!;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        color: getPackageColor(user.id),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: package.packageImages.isNotEmpty &&
                                package.packageImages[0].startsWith('https://')
                            ? NetworkImage(package.packageImages[0])
                            : const AssetImage(MediaRes.box) as ImageProvider,
                      ),
                    ),
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          value: package.name,
                          weight: FontWeight.w600,
                          size: 17,
                        ),
                        BaseText(
                          value: package.formatTotalPrice,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          value: 'receiveDate'.tr(),
                          weight: FontWeight.w600,
                          size: 15,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: BaseText(
                            maxLine: 3,
                            overflow: TextOverflow.ellipsis,
                            value: CoreUtils.parseTimestamp(package.createdAt),
                            weight: FontWeight.normal,
                            size: 15,
                            color: Colors.black.withOpacity(0.7),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          value: 'status'.tr(),
                          weight: FontWeight.w600,
                          size: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 2.5,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: package.status.color,
                          ),
                          child: BaseText(
                            value: package.status.title.toLowerCase().tr(),
                            weight: FontWeight.w500,
                            color: Colors.white,
                            size: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width,
                height: 40,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1)),
                ),
                child: RoundedButton(
                  label: BaseText(
                    value: 'showDetails'.tr(),
                    weight: FontWeight.w500,
                    size: 15,
                    color: Colors.white,
                  ),
                  buttonColour: Colours.primaryColour.withOpacity(0.8),
                  onPressed: () {
                    AppNavigator.pauseAndPushScreen(
                      context: context,
                      routname: PackageDetailsScreen.routeName,
                      delayTime: 0,
                      extra: package,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
