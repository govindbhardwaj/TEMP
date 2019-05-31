import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:daily_quotes/screens/CategoryPage.dart';

import 'package:daily_quotes/helpers/QuoteHelper.dart';
import 'package:daily_quotes/helpers/LocalNotificationHelper.dart';
import "package:daily_quotes/helpers/DateTimeHelper.dart";

import 'package:daily_quotes/bloc/color_bloc.dart';
import 'package:daily_quotes/bloc/font_bloc.dart';
import 'package:daily_quotes/bloc/text_bloc.dart';


final notifications = FlutterLocalNotificationsPlugin();
final qh = new quote_helper();
final _globalKey = new GlobalKey<QuotePageState>();


void main() async {
  final int initialAlarmId = 0;
  await AndroidAlarmManager.initialize();

  runApp(MyApp());

  var initialTime = getNextAlarmTime();
  await AndroidAlarmManager.periodic(Duration(hours: initialTime.hours, minutes: initialTime.minutes, seconds: initialTime.seconds),
      initialAlarmId,
      initialPushNotificationOnDevice);
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


// Push notification relevant methods
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
