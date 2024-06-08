import 'package:flutter/material.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart'
    as noti;

class NotificationsListView<t> extends StatefulWidget {
  final Function() loadMore;
  final Function() onRefresh;
  final Widget Function(t p) child;
  final Widget? onLoadMoreLoading;
  final NotificationsList loadedList;
  const NotificationsListView({
    super.key,
    required this.loadMore,
    required this.onRefresh,
    required this.loadedList,
    this.onLoadMoreLoading,
    required this.child,
  });

  @override
  State<NotificationsListView<t>> createState() =>
      _NotificationsListViewState<t>();
}

class _NotificationsListViewState<t> extends State<NotificationsListView<t>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<noti.Notification> notifications = widget.loadedList.notifications;
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollInfo) {
          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  !widget.loadedList.reachMax
              ? widget.loadMore()
              : null;
          return true;
        },
        child: Container(
          color: Colours.backgroundColour,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: RefreshIndicator(
            onRefresh: () async => widget.onRefresh(),
            child: ListView.builder(
              itemCount: notifications.length + 1,
              itemBuilder: (context, index) {
                if (index == notifications.length &&
                    !widget.loadedList.reachMax) {
                  //showing loader at the bottom of list
                  return widget.onLoadMoreLoading ?? const SizedBox.shrink();
                }

                if (index == notifications.length &&
                    widget.loadedList.reachMax) {
                  return const SizedBox.shrink();
                }
                return widget.child(notifications[index] as t);
              },
            ),
          ),
        ));
  }
}
