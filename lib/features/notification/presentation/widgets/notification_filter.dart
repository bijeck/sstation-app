import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sstation/core/common/widgets/date_picker.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/enums/notification.dart';
import 'package:sstation/core/res/colours.dart';

class NotificationFilter extends StatefulWidget {
  const NotificationFilter({
    super.key,
    required this.onSelectDate,
    required this.onClear,
    required this.onSubmit,
    required this.nameController,
    this.selectedNotificationType,
    this.selectedFrom,
    this.selectedTo,
  });

  final Function(DateTimeRange) onSelectDate;
  final VoidCallback onClear;
  final VoidCallback onSubmit;
  final TextEditingController nameController;

  final NotificationType? selectedNotificationType;
  final String? selectedFrom;
  final String? selectedTo;

  @override
  State<NotificationFilter> createState() => _NotificationFilterState();
}

class _NotificationFilterState extends State<NotificationFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
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
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: SearchBar(
              hintText: 'searchForNotification'.tr(),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              controller: widget.nameController,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              trailing: [
                IconButton(
                  onPressed: () {
                    widget.nameController.clear();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
              leading: const Icon(Icons.search),
            ),
          ),
          DatePicker(
            from: widget.selectedFrom,
            to: widget.selectedTo,
            onDateSelected: widget.onSelectDate,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    radius: 10,
                    onPressed: widget.onClear,
                    label: BaseText(
                      value: 'clear'.tr(),
                      color: Colors.white,
                      size: 18,
                    ),
                    buttonColour: Colours.highStaticColour,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: RoundedButton(
                    radius: 10,
                    onPressed: widget.onSubmit,
                    label: BaseText(
                      value: 'confirm'.tr(),
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
