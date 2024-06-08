import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/app/providers/user_provider.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/double_main_bottom_navigation_bar.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/common/widgets/white_place_holder.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/extensions/package_status_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/constants.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/presentation/bloc/package_bloc.dart';
import 'package:sstation/features/package/presentation/views/packages_screen.dart';
import 'package:sstation/features/package/presentation/widgets/cancel_form.dart';
import 'package:sstation/features/package/presentation/widgets/package_details_container.dart';
import 'package:sstation/features/package/presentation/widgets/package_payment_details_container.dart';
import 'package:sstation/features/package/presentation/widgets/package_status_view_container.dart';
import 'package:sstation/features/package/presentation/widgets/payment_form.dart';
import 'package:sstation/features/package/presentation/widgets/reason_cancel_bottom.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';

class PackageDetailsScreen extends StatefulWidget {
  const PackageDetailsScreen({
    super.key,
    this.package,
    this.id,
  });

  static const routeName = 'package-details';

  final Package? package;
  final String? id;

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  Package? loadedPackage;
  LocalUser? currentUser;
  int? cancelReasonIndex;
  @override
  void initState() {
    currentUser = context.read<UserProvider>().user;
    context.read<PackageBloc>().add(GetPackageEvent(
          id: widget.id,
          package: widget.package,
        ));
    super.initState();
  }

  Widget buttonTitle(Package? package) {
    if (package != null) {
      var status = package.status;
      if (status == PackageStatus.initialized) {
        var message = 'loading'.tr();
        if (currentUser != null) {
          if (currentUser?.id == package.sender.id) {
            message = 'waitingReceive'.tr();
          } else {
            message = 'paynow'.tr();
          }
        }
        return BaseText(
          color: Colors.white,
          value: message,
          size: 20,
        );
      }

      if (status == PackageStatus.paid) {
        if (package.exprireReceiveGoods.isNotEmpty) {
          return TweenAnimationBuilder<Duration>(
              duration:
                  CoreUtils.getRemainDuration(package.exprireReceiveGoods),
              tween: Tween(
                begin: CoreUtils.getRemainDuration(package.exprireReceiveGoods),
                end: Duration.zero,
              ),
              onEnd: () {},
              builder: (BuildContext context, Duration value, Widget? child) {
                final hours = value.inHours;
                final minutes = value.inMinutes % 60;
                final seconds = value.inSeconds % 60;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BaseText(
                        size: 18,
                        color: Colors.white,
                        value: 'waitingReceive'.tr(),
                      ),
                      BaseText(
                        size: 18,
                        color: Colors.white,
                        value:
                            '$hours:${minutes < 10 ? '0$minutes' : minutes}:${seconds < 10 ? '0$seconds' : seconds}',
                      ),
                    ],
                  ),
                );
              });
        } else {
          return BaseText(
            color: Colors.white,
            value: 'paid'.tr(),
            size: 20,
          );
        }
      }
      return BaseText(
        color: Colors.white,
        value: status.name.tr(),
        size: 25,
      );
    }
    return BaseText(
      color: Colors.grey,
      value: 'loading'.tr(),
      size: 25,
    );
  }

  Color buttonColor(Package? package) {
    if (package != null) {
      var status = package.status;
      if (status == PackageStatus.initialized) {
        if (currentUser != null) {
          if (currentUser?.id == package.sender.id) {
            return status.color;
          }
          return Colours.primaryColour;
        } else {
          return Colours.highStaticColour;
        }
      }
      return status.color;
    }
    return Colours.highStaticColour;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'packageDetailsTitle'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.package == null ||
                  loadedPackage == null ||
                  widget.package!.status != loadedPackage!.status) {
                AppNavigator.pauseAndPushNewScreenWithoutBack(
                  context: context,
                  routname: PackageScreen.routeName,
                  delayTime: 0,
                );
              } else {
                AppNavigator.pauseAndPopScreen(
                  context: context,
                  delayTime: 0,
                );
              }
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colours.primaryTextColour,
            ),
          )
        ],
      ),
      body: AppBackground(
        child: BlocConsumer<PackageBloc, PackageState>(
          listener: (_, state) {
            if (state is PackageLoaded) {
              setState(() {
                loadedPackage = state.package;
              });
            }
            if (state is PackagePaidSuccess) {
              AppDialog.showMessageDialog(
                AppDialog.sucessMessage(
                  'paidPackageSuccess'.tr(),
                ),
                closeTime: 2,
              );

              context.read<PackageBloc>().add(
                    GetPackageEvent(
                      id: loadedPackage?.id,
                    ),
                  );
            }
            if (state is PackageCancelSuccess) {
              AppDialog.showMessageDialog(
                AppDialog.sucessMessage(
                  'cancelPackageSuccess'.tr(),
                ),
                closeTime: 1,
              );

              context.read<PackageBloc>().add(
                    GetPackageEvent(
                      id: loadedPackage?.id,
                    ),
                  );
            }
            if (state is PackagePaidFailed) {
              AppDialog.showMessageDialog(
                AppDialog.errorMessage(
                  'paidPackageUnsuccess'.tr(),
                ),
                closeTime: 2,
              );
            }
          },
          builder: (_, state) {
            if (state is PackageLoaded && loadedPackage != null) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WhitePlaceHolder(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colours.primaryColour.withOpacity(0.4),
                        ),
                        child: WhitePlaceHolder(
                          padding: 5,
                          child: QrImageView(
                            data: loadedPackage!.id,
                            version: QrVersions.auto,
                            size: 200.0,
                            // embeddedImage:
                            //     const AssetImage(MediaRes.logoCircle),
                            errorStateBuilder: (cxt, err) {
                              return SizedBox(
                                height: 200,
                                width: 200,
                                child: Center(
                                  child: Text(
                                    'somethingWentWrong'.tr(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    WhitePlaceHolder(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Colours.secondayTextColour,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: BaseText(
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                              value:
                                  '${loadedPackage!.station.name} ${loadedPackage!.station.address}',
                              weight: FontWeight.normal,
                              size: 15,
                              color: Colours.secondayTextColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    WhitePlaceHolder(
                      child: PackageStatusViewContainer(
                        packageStatusHistories:
                            loadedPackage!.packageStatusHistories,
                      ),
                    ),
                    const SizedBox(height: 10),
                    WhitePlaceHolder(
                      child: PackageDetailsContainer(package: loadedPackage!),
                    ),
                    const SizedBox(height: 10),
                    WhitePlaceHolder(
                      child: PackagePaymentDetailsContainer(
                        package: loadedPackage!,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PackagesError) {
              return Center(
                child: BaseText(
                  value: state.message,
                  size: 15,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: DoubleMainButtonNavigationBar(
        label: buttonTitle(loadedPackage),
        onCancel: () {
          if (loadedPackage!.status == PackageStatus.initialized &&
              currentUser != null &&
              currentUser!.id != loadedPackage!.sender.id) {
            AppDialog.showModelBottomBottomSheet(
              context: context,
              child: ReasonCancel(
                onSelected: (index) {
                  setState(() {
                    cancelReasonIndex = index;
                  });
                },
                onConfirm: () {
                  Navigator.pop(context);
                  AppDialog.showMessageDialog(
                    CancelForm(
                      onCancel: () {
                        setState(() {
                          cancelReasonIndex = null;
                          SmartDialog.dismiss();
                        });
                      },
                      onSuccess: () {
                        SmartDialog.dismiss();
                        context.read<PackageBloc>().add(
                              CancelPackageEvent(
                                id: loadedPackage!.id,
                                reason: cancelReasons[cancelReasonIndex!],
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
        func: () {
          if (currentUser != null &&
              currentUser!.id != loadedPackage!.sender.id &&
              loadedPackage != null) {
            if (loadedPackage!.status == PackageStatus.initialized) {
              if (currentUser!.wallet.balance >= loadedPackage!.totalPrice) {
                AppDialog.showMessageDialog(
                  ConfirmPaymentForm(
                    onCancel: () => SmartDialog.dismiss(),
                    onSuccess: () {
                      SmartDialog.dismiss();
                      context.read<PackageBloc>().add(
                            PayPackageEvent(
                              id: loadedPackage!.id,
                              totalPrice: loadedPackage!.totalPrice,
                            ),
                          );
                    },
                  ),
                );
              } else {
                AppDialog.showMessageDialog(
                  AppDialog.errorMessage(
                    'Your wallet do not have enough money. Please deposit more!',
                  ),
                );
              }
            }
          }
        },
        backgroundColor: Colors.white,
        buttonColor: buttonColor(loadedPackage),
        lableColor: Colors.white,
      ),
    );
  }
}
