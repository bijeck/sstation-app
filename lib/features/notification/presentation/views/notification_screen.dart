import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/providers/hive_provider.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/notification/domain/entities/notifications_list.dart';
import 'package:sstation/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:sstation/features/notification/presentation/widgets/notification_card.dart';
import 'package:sstation/features/notification/presentation/widgets/notification_filter.dart';
import 'package:sstation/features/notification/presentation/widgets/notification_loading.dart';
import 'package:sstation/features/notification/presentation/widgets/notification_loading_card.dart';
import 'package:sstation/features/notification/presentation/widgets/notifications_list_view.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart'
    as noti;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const routeName = 'user-notifications';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? from;
  String? filterName;
  String? to;
  bool? isRead;
  TextEditingController nameController = TextEditingController();
  NotificationsList loadedList = NotificationsList.reset();
  var isShow = false;
  var deleteMode = false;
  List<int> deletedId = [];

  @override
  void initState() {
    context.read<NotificationBloc>().add(const GetNotificationsListEvent());
    super.initState();
  }

  void _onClear() {
    setState(() {
      from = null;
      to = null;
      filterName = null;
      nameController.clear();
      context.read<NotificationBloc>().add(const GetNotificationsListEvent());
    });
  }

  void _onHover(int id) {
    setState(() {
      deleteMode = true;
      deletedId.add(id);
    });
  }

  void clickDelete(bool selected, int id) {
    if (selected) {
      setState(() {
        deletedId.add(id);
      });
    } else {
      setState(() {
        deletedId.remove(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColour,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'notificationTitle'.tr(),
          weight: FontWeight.w600,
          color: Colors.white,
          size: 25,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.checklist_rounded,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                for (var element in loadedList.notifications) {
                  element.isRead = true;
                }
                HiveProvider.clearAllNotification();
                context
                    .read<NotificationBloc>()
                    .add(const ReadAllNotificationEvent());
              });
            },
          ),
          IconButton(
            icon: Icon(
              isShow
                  ? Icons.filter_alt_off_outlined
                  : Icons.filter_alt_outlined,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isShow,
            child: NotificationFilter(
              onClear: _onClear,
              onSelectDate: (value) => setState(() {
                from = CoreUtils.parseDate(value.start);
                to = CoreUtils.parseDate(value.end);
              }),
              nameController: nameController,
              onSubmit: () {
                context.read<NotificationBloc>().add(
                      GetNotificationsListEvent(
                        search: nameController.text,
                        from: from,
                        to: to,
                        isRead: isRead,
                      ),
                    );
              },
              selectedFrom: from,
              selectedTo: to,
            ),
          ),
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationsListLoaded) {
                  loadedList = state.notifications;
                  return NotificationsListView<noti.Notification>(
                    loadedList: loadedList,
                    onRefresh: _onClear,
                    loadMore: () {
                      context.read<NotificationBloc>().add(
                            NotificationsLoadMoreEvent(
                              search: filterName,
                              from: from,
                              to: to,
                              isRead: isRead,
                            ),
                          );
                    },
                    onLoadMoreLoading: const NotificationLoadingCard(),
                    child: (noti.Notification notification) {
                      return NotificationCard(
                        notification: notification,
                        deleteMode: deleteMode,
                        selectDelete: deletedId.contains(notification.id),
                        clickDelete: clickDelete,
                        onHover: _onHover,
                      );
                    },
                  );
                }
                if (state is NotificationsLoading) {
                  return const NotificationLoading(initLoad: 12);
                }
                if (state is NotificationsError) {
                  return Center(
                    child: BaseText(
                      value: state.message,
                      size: 15,
                    ),
                  );
                }
                if (state is NotificationsEmpty) {
                  return Center(
                    child: BaseText(
                      value: 'emptyNotification'.tr(),
                      size: 15,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: deleteMode
          ? Container(
              decoration: BoxDecoration(
                color: Colours.secondaryColour,
                boxShadow: [
                  BoxShadow(
                    color: Colours.highStaticColour.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 30, right: 5, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          deleteMode = false;
                          deletedId = [];
                        });
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colours.primaryTextColour,
                      ),
                      label: BaseText(value: 'cancel'.tr())),
                  IconButton(
                      onPressed: () {
                        AppDialog.showConfirm(
                            child: BaseText(
                              value: 'confirmDeleteNotification'.tr(),
                              size: 20,
                              color: Colours.primaryTextColour,
                            ),
                            onCancel: () {
                              setState(() {
                                deleteMode = false;
                                deletedId = [];
                                AppDialog.closeDialog();
                              });
                            },
                            onSuccess: () {
                              context.read<NotificationBloc>().add(
                                  DeleteNotificationsEvent(ids: deletedId));
                              setState(() {
                                deleteMode = false;
                                deletedId = [];
                                AppDialog.closeDialog();
                              });
                            });
                      },
                      iconSize: 30,
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colours.primaryTextColour,
                      )),
                ],
              ))
          : const SizedBox.shrink(),
    );
  }
}
