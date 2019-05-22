import 'dart:isolate';

import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:daily_quotes/screens/CategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:daily_quotes/helpers/quote_helper.dart';


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:daily_quotes/helpers/second_page.dart';
import 'package:daily_quotes/helpers/local_notification_helper.dart';

final notifications = FlutterLocalNotificationsPlugin();

quote_helper qh = new quote_helper();

final _globalKey = new GlobalKey<QuotePageState>();
//final navigatorKey = new GlobalKey<NavigatorState>();

void printHello() async {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  String quote = await qh.getQuote();
  print("[$now] [$quote] isolate=${isolateId} function='$printHello'");

  showIconNotification(
    _globalKey.currentContext,
    notifications,
    icon: Image.asset("assets/screen.png"),
    title: "Quote of the day",
    body: quote,
    id: 40
  );

}

Future onSelectNotification(String payload) async {
  print("Payload : " + payload);
  Navigator.of(_globalKey.currentContext).push(MaterialPageRoute(builder: (context) => QuotesPage(payload)));
  var push = Navigator.of(app.context2).push(MaterialPageRoute(builder: (context) => QuotesPage(payload)));
  print(push);
}

MyApp app = new MyApp();

void main() async {
  final settingsAndroid = AndroidInitializationSettings('@mipmap/screen');
  final settingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(payload));
  notifications.initialize(InitializationSettings(settingsAndroid, settingsIOS), onSelectNotification: onSelectNotification);
  final int helloAlarmID = 0;

  await AndroidAlarmManager.initialize();

  runApp(app);

  await AndroidAlarmManager.periodic(const Duration(seconds: 10), helloAlarmID, printHello);
}

class MyApp extends StatelessWidget {

  BuildContext context2;

  @override
  Widget build(BuildContext context) {
    context2 = context;

    return MaterialApp(
      title: 'Daily Quotes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: CategoryPage()
    );
  }
}
