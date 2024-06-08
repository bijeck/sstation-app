import 'package:flutter/material.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/res/colours.dart';

extension UserTypeExt on UserType {
  String get title {
    switch (this) {
      case UserType.receiver:
        return 'Receiver';
      case UserType.sender:
        return 'Sender';
      default:
        return 'Unknow User';
    }
  }

  Color get color {
    switch (this) {
      case UserType.receiver:
        return Colours.secondaryColour;
      case UserType.sender:
        return Colours.sentPackageColour;
      default:
        return Colours.staticColour;
    }
  }
}
