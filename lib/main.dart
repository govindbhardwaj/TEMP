import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:daily_quotes/screens/CategoryPage.dart';
import 'package:daily_quotes/helpers/quote_helper.dart';
import 'package:daily_quotes/helpers/local_notification_helper.dart';

final notifications = FlutterLocalNotificationsPlugin();
final qh = new quote_helper();
final _globalKey = new GlobalKey<QuotePageState>();

void pushNotificationOnDevice() async {
  final DateTime now = DateTime.now();
  String quote = await qh.getQuote();
  print("[$now] [$quote]");

  showIconNotification(_globalKey.currentContext, notifications,
      icon: Image.asset("assets/screen.png"),
      title: "Quote of the day",
      body: quote,
      id: 40);
}

void main() async {
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();

  runApp(MyApp());
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 10), helloAlarmID, pushNotificationOnDevice);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Daily Quotes',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: CategoryPage());
  }
}
