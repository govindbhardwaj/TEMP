import 'package:daily_quotes/screens/CardPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:daily_quotes/helpers/local_notification_helper.dart';
import 'package:daily_quotes/helpers/second_page.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {

  final notifications = FlutterLocalNotificationsPlugin();
//
//  @override
//  void initState() {
//    super.initState();
//
//    final settingsAndroid = AndroidInitializationSettings('@mipmap/screen');
//    final settingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: (id, title, body, payload) =>
//            onSelectNotification(payload));
//
//    notifications.initialize(
//        InitializationSettings(settingsAndroid, settingsIOS),
//        onSelectNotification: onSelectNotification);
//  }
//
//
//
//  Future onSelectNotification(String payload) async {
//    print("Payload : " + payload);
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => CardPage(payload)),
//    );
//
//  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text('Show image (big+small)'),
              onPressed: () => showIconNotification(
                    context,
                    notifications,
                    icon: Image.asset('assets/screen.png'),
                    title: 'IconAndImageTitle',
                    body: 'IconAndImageBody',
                    id: 40,
                  ),
            )
          ],
        ),
      );
}
