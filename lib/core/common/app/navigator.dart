import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/services/router/router.dart';

class AppNavigator {
  static void pauseAndPushScreen({
    required BuildContext context,
    required String routname,
    required int delayTime,
    Map<String, dynamic>? arguments,
    Object? extra,
  }) {
    Timer(
      Duration(seconds: delayTime),
      () {
        AppDialog.closeDialog();
        context.go(
          AppRoute.parseRoute(
            route: '/$routname',
            queryParameters: arguments,
          ),
          extra: extra,
        );
      },
    );
  }

  static void pauseAndPopScreen({
    required BuildContext context,
    required int delayTime,
  }) {
    Timer(
      Duration(seconds: delayTime),
      () {
        AppDialog.closeDialog();
        context.pop();
      },
    );
  }

  static void pauseAndPushNewScreenWithoutBack({
    required BuildContext context,
    required String routname,
    required int delayTime,
    Map<String, dynamic>? arguments,
    Object? extra,
  }) {
    Timer(
      Duration(seconds: delayTime),
      () {
        AppDialog.closeDialog();
        while (context.canPop()) {
          context.pop();
        }
        context.pushReplacement(
          AppRoute.parseRoute(
            route: '/$routname',
            queryParameters: arguments,
          ),
          extra: extra,
        );
      },
    );
  }
}
