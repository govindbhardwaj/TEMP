import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:daily_quotes/screens/CardPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);
  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  List<String> quotesCategory = [
    "Inspirational Quotes",
    "Motivational Quotes",
    "Positive Quotes",
    "Success Quotes",
    "Inspirational Quotes About Life",
    "Short Inspirational Quotes",
    "Words Of Encouragement",
    "Inspirational Quotes For Encouragement",
    "Short Encouraging Quotes",
    "Positive Encouraging Quotes"
  ];

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('@mipmap/screen');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    print("Payload from Category: " + payload);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardPage(payload)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Daily Quote'),
        ),
        body: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                  child: ListTile(
                    leading: new Icon(Icons.bookmark_border),
                    title: Text(quotesCategory[position]),
                    trailing: const Icon(Icons.format_quote),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuotesPage(quotesCategory[position])));
                    },
                  ),
                );
              },
              itemCount: quotesCategory.length,
            )));
  }
}
