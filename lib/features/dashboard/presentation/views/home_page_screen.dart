import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/app/providers/hive_provider.dart';

import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/dashboard/presentation/widgets/money_view_container.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';
import 'package:sstation/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:sstation/features/notification/presentation/views/notification_screen.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:sstation/features/station/domain/entities/station.dart';
import 'package:sstation/features/station/domain/entities/stations_list.dart';
import 'package:sstation/features/station/presentation/bloc/station_bloc.dart';
import 'package:sstation/features/station/presentation/widgets/station_card.dart';
import 'package:sstation/features/station/presentation/widgets/station_loading.dart';
import 'package:sstation/features/station/presentation/widgets/stations_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static const String routeName = 'home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  String? searchStation;
  TextEditingController searchStationController = TextEditingController();
  StationsList stations = StationsList.reset();
  NotificationsList notifications = NotificationsList.reset();

  @override
  void initState() {
    searchStation = '';
    context.read<StationBloc>().add(const FetchStationsEvent());
    context.read<UserProfileBloc>().add(const InitUserProfileEvent());
    context.read<NotificationBloc>().add(const GetNotificationsListEvent());
    super.initState();
  }

  void _loadMoreStation() {
    if (searchStation!.isNotEmpty) {
      context.read<StationBloc>().add(
            StationsLoadMoreEvent(
              search: searchStation,
            ),
          );
    } else {
      context.read<StationBloc>().add(
            const StationsLoadMoreEvent(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: BaseText(
            value: CoreUtils.welcomeTitleByTime(),
            weight: FontWeight.w600,
            size: 25,
          ),
          actions: [
            BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is NotificationsListLoaded) {
                  HiveProvider.initNotification(
                      state.notifications.countUnread);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('notification').listenable(),
                  builder: (context, Box box, widget) {
                    int count = box.get('unReadNotiCount', defaultValue: 0);
                    return InkWell(
                      onTap: () => AppNavigator.pauseAndPushScreen(
                        context: context,
                        routname: NotificationScreen.routeName,
                        delayTime: 0,
                      ),
                      child: Badge(
                          label: Text('$count'),
                          isLabelVisible: count > 0,
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            size: 35,
                            color: Colours.highStaticColour,
                          )),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: AppBackground(
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (scrollInfo) {
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent
                  ? _loadMoreStation()
                  : null;
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  searchStation = '';
                  searchStationController.clear();
                  context.read<StationBloc>().add(const FetchStationsEvent());
                  context
                      .read<UserProfileBloc>()
                      .add(const InitUserProfileEvent());
                  context
                      .read<NotificationBloc>()
                      .add(const GetNotificationsListEvent());
                });
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileLoaded) {
                          context.userProvider.initUser(state.user);
                          LocalUser user = state.user;
                          return Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              MoneyViewContainer(wallet: user.wallet),
                              Positioned(
                                top: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colours.backgroundColour,
                                    borderRadius: BorderRadius.circular(50),
                                    image: const DecorationImage(
                                      image: AssetImage(MediaRes.wallet),
                                    ),
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ],
                          );
                        } else if (state is UserProfileLoading) {
                          return Container(
                            height: context.height * 0.2,
                            margin: const EdgeInsets.only(
                                top: 60, bottom: 30, left: 20, right: 20),
                            padding: const EdgeInsets.only(
                                right: 5, left: 5, top: 35, bottom: 5),
                            width: context.width - 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colours.highStaticColour.withOpacity(0.5),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return Center(child: Text(AppMessage.serverError));
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            value: '${'stations'.tr()}:',
                            color: Colours.primaryTextColour,
                            weight: FontWeight.w500,
                            size: 18,
                          ),
                          SizedBox(
                            height: 40,
                            width: context.width * 0.6,
                            child: TextField(
                              maxLength: 15,
                              maxLines: 1,
                              controller: searchStationController,
                              textAlignVertical: TextAlignVertical.bottom,
                              onSubmitted: (value) {
                                context.read<StationBloc>().add(
                                      FetchStationsEvent(search: value),
                                    );
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: 'searchForStation'.tr(),
                                hintStyle: const TextStyle(
                                    color: Colours.highStaticColour),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colours.primaryTextColour,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (searchStationController
                                        .value.text.isNotEmpty) {
                                      searchStationController.clear();
                                      context.read<StationBloc>().add(
                                            const FetchStationsEvent(),
                                          );
                                    }
                                  },
                                  icon: const Icon(Icons.close,
                                      color: Colours.primaryTextColour),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    StationsListView(
                      loadMore: _loadMoreStation,
                      initialEmpty: const Center(
                        child: BaseText(
                          value: 'Dont have any station yet!',
                          size: 15,
                        ),
                      ),
                      initialLoading: const StationLoading(),
                      onLoadMoreLoading:
                          const Center(child: CircularProgressIndicator()),
                      child: (Station station) {
                        return StationCard(station: station);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
