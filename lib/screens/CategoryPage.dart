import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

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
    "Life Quotes",
    "Short Inspirational Quotes",
    "Words Of Encouragement",
    "Encouraging Quotes"
  ];

  final notifications = FlutterLocalNotificationsPlugin();

  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['quotes', 'inspiration', 'motivation', 'category'],
    birthday: new DateTime.now(),
    childDirected: true,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-1790548623336527/7780948871",
        size: AdSize.smartBanner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner event : $event");
        });
  }

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
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1790548623336527~7884681226");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
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
          title: new Text('Daily Quote', style: TextStyle(fontFamily: "Quicksand")),

        ),
        body: new Container(

            padding: new EdgeInsets.all(20.0),
            child: new ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                  margin: new EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: new Icon(
                      Icons.bookmark,
                      color: Colors.pink.shade900,
                    ),
                    title: Text(quotesCategory[position], style: TextStyle(fontFamily: "Quicksand"),),
                    trailing: new Icon(
                      Icons.format_quote,
                      color: Colors.pink.shade900,
                    ),
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
