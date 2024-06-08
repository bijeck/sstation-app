// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/services/injections/injections.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/dashboard/presentation/views/home_page_screen.dart';
import 'package:sstation/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:sstation/features/package/presentation/bloc/package_bloc.dart';
import 'package:sstation/features/package/presentation/views/packages_screen.dart';
import 'package:sstation/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:sstation/features/profile/presentation/views/user_profile_screen.dart';
import 'package:sstation/features/station/presentation/bloc/station_bloc.dart';
import 'package:sstation/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:sstation/features/transaction/presentation/views/transactions_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    this.initIndex = 0,
  });

  final int initIndex;

  static const String routeName = 'dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PersistentTabController _controller;

  bool isHomePage = true;

  @override
  void initState() {
    super.initState();
    if (widget.initIndex != 0) isHomePage = false;
    _controller = PersistentTabController(initialIndex: widget.initIndex);
  }

  List<Widget> _buildScreens(PersistentTabController controller) {
    return [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UserProfileBloc>(),
          ),
          BlocProvider(
            create: (_) => getIt<StationBloc>(),
          ),
          BlocProvider(
            create: (_) => getIt<NotificationBloc>(),
          ),
        ],
        child: const HomePage(),
      ),
      BlocProvider(
        create: (_) => getIt<PackageBloc>(),
        child: const PackageScreen(),
      ),
      BlocProvider(
        create: (_) => getIt<TransactionBloc>(),
        child: const TransactionScreen(),
      ),
      BlocProvider(
        create: (_) => getIt<AuthBloc>(),
        child: const UserProfileScreen(),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontSize: 11),
        icon: isHomePage
            ? Container(
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colours.primaryColour,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/logo/logo_zoom.png'),
                  ),
                ),
              )
            : Container(
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colours.highStaticColour,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/logo/logo_grey.png'),
                  ),
                ),
              ),
        title: 'home'.tr(),
        activeColorPrimary: Colours.primaryColour,
        inactiveColorPrimary: Colours.highStaticColour,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        icon: const Icon(
          OctIcons.package_16,
        ),
        textStyle: const TextStyle(fontSize: 11),
        title: 'packages'.tr(),
        activeColorPrimary: Colours.primaryColour,
        inactiveColorPrimary: Colours.highStaticColour,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 11),
        icon: const Icon(Icons.history_outlined),
        title: 'transactions'.tr(),
        activeColorPrimary: Colours.primaryColour,
        inactiveColorPrimary: Colours.highStaticColour,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        textStyle: const TextStyle(fontSize: 11),
        icon: const Icon(Icons.account_circle_outlined),
        title: 'me'.tr(),
        activeColorPrimary: Colours.primaryColour,
        inactiveColorPrimary: Colours.highStaticColour,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(_controller),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colours.backgroundColour,
        handleAndroidBackButtonPress: true,
        onItemSelected: (int num) {
          if (num == 0) {
            setState(() {
              isHomePage = true;
            });
          } else {
            setState(() {
              isHomePage = false;
            });
          }
        },
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
            ),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
