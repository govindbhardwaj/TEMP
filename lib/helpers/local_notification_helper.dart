import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:daily_quotes/helpers/utils.dart';

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

GlobalKey _globalKey = new GlobalKey();

//Future<NotificationDetails> _imageAndIcon(
//    BuildContext context, Image picture, Image icon) async {
//  final iconPath = await saveImage(context, icon);
//  final picturePath = await saveImage(context, picture);
//
//  final bigPictureStyleInformation = BigPictureStyleInformation(
//    picturePath,
//    BitmapSource.FilePath,
//    largeIcon: iconPath,
//    largeIconBitmapSource: BitmapSource.FilePath,
//  );
//
//  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//    'big text channel id',
//    'big text channel name',
//    'big text channel description',
//    style: AndroidNotificationStyle.BigText,
//    styleInformation: bigPictureStyleInformation,
//  );
//  return NotificationDetails(androidPlatformChannelSpecifics, null);
//}
//
//Future showIconAndImageNotification(
//  BuildContext context,
//  FlutterLocalNotificationsPlugin notifications, {
//  @required String title,
//  @required String body,
//  @required Image picture,
//  @required Image icon,
//  int id = 0,
//}) async =>
//    notifications.show(
//        id, title, body, await _imageAndIcon(context, picture, icon), payload: "mukesh");


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

Future<String> saveImage(BuildContext context, Image image) {
  final completer = Completer<String>();

  image.image.resolve(ImageConfiguration()).addListener((imageInfo, _) async {
    final byteData =
    await imageInfo.image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData.buffer.asUint8List();

    final fileName = pngBytes.hashCode;
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(pngBytes);

    completer.complete(filePath);
  });

  return completer.future;
}
