import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sstation/core/common/widgets/date_picker.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';

import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/core/utils/typedefs.dart';

class PackageFilterSheet extends StatefulWidget {
  const PackageFilterSheet({
    super.key,
    required this.onSubmit,
    required this.fromDate,
    required this.toDate,
    required this.nameController,
    required this.onClear,
  });

  final SubmitVoidFunc onSubmit;
  final VoidCallback onClear;
  final String? fromDate;
  final String? toDate;
  final TextEditingController nameController;

  @override
  State<PackageFilterSheet> createState() => _PackageFilterSheetState();
}

class _PackageFilterSheetState extends State<PackageFilterSheet> {
  late String? from;
  late String? to;

  @override
  void initState() {
    from = widget.fromDate;
    to = widget.toDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: Colours.backgroundColour,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SearchBar(
            hintText: 'seachForPackages'.tr(),
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
          const SizedBox(height: 30),
          DatePicker(
              from: from,
              to: to,
              onDateSelected: (value) {
                setState(() {
                  from = CoreUtils.parseDate(value.start);
                  to = CoreUtils.parseDate(value.end);
                });
              }),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  radius: 10,
                  onPressed: () {
                    setState(() {
                      widget.onClear();
                      from = null;
                      to = null;
                    });
                  },
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
                  onPressed: () {
                    widget.onSubmit(from, to, widget.nameController.text);
                    Navigator.pop(context);
                  },
                  label: BaseText(
                    value: 'search'.tr(),
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
