import 'package:flutter/material.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/res/colours.dart';

extension PackageStatusExt on PackageStatus {
  String get title {
    switch (this) {
      case PackageStatus.initialized:
        return 'Initialized';
      case PackageStatus.returned:
        return 'Returned';
      case PackageStatus.completed:
        return 'Completed';
      case PackageStatus.canceled:
        return 'Canceled';
      case PackageStatus.paid:
        return 'Paid';
      default:
        return 'Unknown';
    }
  }

  Color get color {
    switch (this) {
      case PackageStatus.initialized:
        return Colours.primaryColour;
      case PackageStatus.returned:
        return Colors.red;
      case PackageStatus.paid:
        return Colors.green;
      case PackageStatus.completed:
        return Colors.green;
      case PackageStatus.canceled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
