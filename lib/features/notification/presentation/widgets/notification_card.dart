import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/providers/hive_provider.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/notification_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart'
    as noti;
import 'package:sstation/features/notification/presentation/bloc/notification_bloc.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.deleteMode,
    required this.selectDelete,
    required this.onHover,
    required this.clickDelete,
  });
  final noti.Notification notification;
  final bool deleteMode;
  final bool selectDelete;
  final Function(int) onHover;
  final Function(bool, int) clickDelete;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        widget.onHover(widget.notification.id);
      },
      onTap: () {
        if (!widget.notification.isRead) {
          setState(() {
            widget.notification.isRead = true;
            HiveProvider.subtractNotification();
            context
                .read<NotificationBloc>()
                .add(ReadNotificationEvent(id: widget.notification.id));
          });
        }
      },
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 1,
              ),
            ],
            color:
                widget.notification.isRead ? Colors.white : Colors.yellow[100],
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(widget.notification.type.image),
                  ),
                ),
                width: 45,
                height: 45,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      maxLine: 2,
                      value: widget.notification.title,
                      weight: FontWeight.bold,
                      size: 14,
                      color: Colours.secondayTextColour,
                    ),
                    const SizedBox(height: 5),
                    BaseText(
                      maxLine: 3,
                      overflow: TextOverflow.ellipsis,
                      value: widget.notification.content,
                      weight: FontWeight.normal,
                      size: 13,
                      color: Colours.primaryTextColour,
                    ),
                    const SizedBox(height: 5),
                    BaseText(
                      value: CoreUtils.parseTimestamp(
                          widget.notification.createdAt),
                      weight: FontWeight.normal,
                      size: 13,
                      color: Colours.primaryTextColour,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: SizedBox(
            width: 50,
            child: Visibility(
              visible: widget.deleteMode,
              child: Checkbox(
                // checkColor: Colours.primaryColour,
                focusColor: Colours.primaryColour,
                activeColor: Colours.primaryColour,
                value: widget.selectDelete,
                onChanged: (selected) {
                  setState(() {
                    widget.clickDelete(selected!, widget.notification.id);
                  });
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
