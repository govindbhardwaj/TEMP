import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:daily_quotes/helpers/utils.dart';

import 'dart:async';
import 'dart:ui';


Future showIconNotification(
  BuildContext context,
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required Image icon,
  int id = 0,
}) async {
  notifications.show(id, title, body, await _icon(context, icon),
      payload: body);
}

Future<NotificationDetails> _icon(BuildContext context, Image icon) async {
  final iconPath = await saveImage(context, icon);

  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'big text channel id',
    'big text channel name',
    'big text channel description',
    largeIcon: iconPath,
    largeIconBitmapSource: BitmapSource.FilePath,
    style: AndroidNotificationStyle.BigText,
  );
  return NotificationDetails(androidPlatformChannelSpecifics, null);
}

