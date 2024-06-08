// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.leading,
  });

  final Widget title;
  final Icon icon;
  final VoidCallback onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              icon,
              const SizedBox(width: 20),
              title,
            ],
          )),
          const SizedBox(width: 20),
          InkWell(
            onTap: onTap,
            child: leading ??
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colours.primaryTextColour,
                  size: 20,
                ),
          ),
        ],
      ),
    );
  }
}
