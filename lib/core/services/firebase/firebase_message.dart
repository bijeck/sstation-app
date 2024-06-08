import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:sstation/core/common/app/providers/hive_provider.dart';
import 'package:sstation/core/services/firebase/local_message.dart';
import 'package:sstation/core/services/router/router.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/package/presentation/views/package_details_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  logger.i('Handling a background message: ${message.messageId}');
  logger.i('Title: ${message.notification?.title}');
  logger.i('Body: ${message.notification?.body}');
}

class FirebaseMessage {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //Firebase messaging
      _firebaseMessaging.getToken().then((token) async {
        if (!await Hive.boxExists('token')) {
          await Hive.openBox('token');
        }
        if (!Hive.isBoxOpen('token')) {
          await Hive.openBox('token');
        }
        var tokenBox = Hive.box('token');
        await tokenBox.put('fcmToken', token);
      });
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          HiveProvider.addNotification();
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
            payload: message.data['Data'].toString(),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        HiveProvider.addNotification();
        final router = AppRoute.router;
        if (message.data.containsKey('Data')) {
          var payload = message.data['Data'].toString();
          if (payload.contains('PackageId')) {
            var data = jsonDecode(payload);
            router.go(
                '/${PackageDetailsScreen.routeName}/?id=${data['PackageId']}');
          } else {
            router.go('/');
          }
        } else {
          router.go('/');
        }
      }
    });
  }
}
