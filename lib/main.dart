import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:daily_quotes/bloc/color_bloc.dart';
import 'package:daily_quotes/bloc/font_bloc.dart';
import 'package:daily_quotes/bloc/text_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:daily_quotes/screens/CategoryPage.dart';
import 'package:daily_quotes/helpers/quote_helper.dart';
import 'package:daily_quotes/helpers/local_notification_helper.dart';
import 'package:provider/provider.dart';

final notifications = FlutterLocalNotificationsPlugin();
final qh = new quote_helper();
final _globalKey = new GlobalKey<QuotePageState>();

void initialPushNotificationOnDevice() async {
  final DateTime now = DateTime.now();
  String quote = await qh.getQuote();
  print("[$now] [$quote]");

  showIconNotification(_globalKey.currentContext, notifications,
      icon: Image.asset("assets/screen.png"),
      title: "Quote of the day",
      body: quote,
      id: 40);

    await AndroidAlarmManager.cancel(0);
    await AndroidAlarmManager.periodic(const Duration(hours: 24), 1, pushNotificationOnDevice);
}

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
  final int initialAlarmId = 0;
  await AndroidAlarmManager.initialize();

  runApp(MyApp());

  var initialTime = getNextAlarmTime();
  await AndroidAlarmManager.periodic(Duration(hours: initialTime.hours, minutes: initialTime.minutes, seconds: initialTime.seconds), initialAlarmId, initialPushNotificationOnDevice);
  //await AndroidAlarmManager.periodic(Duration(hours: 0, minutes: 1, seconds: initialTime.seconds), initialAlarmId, initialPushNotificationOnDevice);
}

Time getNextAlarmTime() {
  DateTime dateTime = DateTime.now();
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  int second = dateTime.second;

  //9AM is hardCoded
  int expectedHour = 8;
  int expectedMinute = 0;
  int expectedSecond = 0;

  int x;
  int y;
  int z;

  if(hour > expectedHour) {
    x = 24 - hour + 8 - 1;
  }
  else {
    x= expectedHour - hour;
  }
  if(minute > expectedMinute) {
    y = 60 - minute;
  }
  else
    y = expectedMinute - minute;

  if(second > expectedSecond) {
    z = 60 - second;
  }
  else {
    z = expectedSecond - second;
  }

  print("Hours: $x Minutes: $y Seconds: $z");
  return new Time(x, y, z);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeBloc>.value(notifier: ThemeBloc()),
          ChangeNotifierProvider<TextBloc>.value(notifier: TextBloc()),
          ChangeNotifierProvider<FontBloc>.value(notifier: FontBloc())
        ],
        child: new MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.pink
          ),
          title: 'Dily Quote',
          home: new CategoryPage(),
        ));
  }
}

class Time{
  int hours;
  int minutes;
  int seconds;
  Time(this.hours, this.minutes, this.seconds);
}