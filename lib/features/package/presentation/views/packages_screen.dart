// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/dialog.dart';

import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/extensions/user_type_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/presentation/bloc/package_bloc.dart';
import 'package:sstation/features/package/presentation/widgets/package_filter_sheet.dart';
import 'package:sstation/features/package/presentation/widgets/package_loading.dart';
import 'package:sstation/features/package/presentation/widgets/package_card.dart';
import 'package:sstation/features/package/presentation/widgets/package_loading_card.dart';
import 'package:sstation/features/package/presentation/widgets/packages_list_view.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  static const routeName = 'user-packages';

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  UserType? userType;
  String? filterName;
  String? from;
  String? to;
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    context.read<PackageBloc>().add(const GetPackagesListEvent());
    super.initState();
  }

  void _onRefresh() {
    setState(() {
      from = null;
      to = null;
      filterName = null;
      nameController.clear();
      context.read<PackageBloc>().add(
            GetPackagesListEvent(
              type: userType,
              name: filterName,
              from: from,
              to: to,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: userType != null
              ? userType == UserType.receiver
                  ? 'receivePackagesTitle'.tr()
                  : 'sentPackagesTitle'.tr()
              : 'packages'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune,
              size: 35,
              color: Colours.primaryTextColour,
            ),
            onPressed: () {
              AppDialog.showModelBottomBottomSheet(
                context: context,
                child: PackageFilterSheet(
                  toDate: to,
                  fromDate: from,
                  onClear: () {
                    setState(() {
                      from = null;
                      to = null;
                      filterName = null;
                      nameController.clear();
                    });
                  },
                  onSubmit: (fromDate, toDate, name) {
                    setState(() {
                      from = fromDate;
                      to = toDate;
                      filterName = name;

                      context.read<PackageBloc>().add(
                            GetPackagesListEvent(
                              name: filterName!.isEmpty ? null : filterName,
                              type: userType,
                              from: from,
                              to: to,
                            ),
                          );
                    });
                  },
                  nameController: nameController,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colours.backgroundColour,
              boxShadow: [
                BoxShadow(
                  color: Colours.highStaticColour.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: UserType.values
                  .map((type) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: FilterChip(
                          side: BorderSide(
                            color: Colours.highStaticColour.withOpacity(0.15),
                          ),
                          backgroundColor: Colours.backgroundColour,
                          selectedColor: type.color,
                          label: BaseText(
                            value: type.title.toLowerCase().tr(),
                            color: Colours.primaryTextColour,
                            size: 15,
                          ),
                          selected: userType != null ? type == userType : false,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                userType = type;
                              } else {
                                userType = null;
                              }
                              context
                                  .read<PackageBloc>()
                                  .add(GetPackagesListEvent(
                                    type: userType,
                                    name: filterName,
                                    from: from,
                                    to: to,
                                  ));
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: PackagesListView<Package>(
              onRefresh: _onRefresh,
              loadMore: () {
                context.read<PackageBloc>().add(
                      PackagesLoadMoreEvent(
                        type: userType,
                        name: filterName,
                        from: from,
                        to: to,
                      ),
                    );
              },
              initialEmpty: Center(
                child: BaseText(
                  value: 'emptyPackage'.tr(),
                  size: 15,
                ),
              ),
              initialLoading: const PackageLoading(init: 3),
              onLoadMoreLoading: const PackageLoadingCard(),
              child: (Package package) {
                return PackageCard(package: package);
              },
            ),
          ),
        ],
      ),
    );
  }
}
