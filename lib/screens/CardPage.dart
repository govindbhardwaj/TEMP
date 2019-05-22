import 'dart:typed_data';

import 'package:daily_quotes/screens/CategoryPage.dart';
import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:daily_quotes/helpers/second_page.dart';
import 'package:daily_quotes/helpers/local_notification_helper.dart';


class CardPage extends StatefulWidget {
  String category;
  CardPage(this.category);

  @override
  CardPageState createState() => CardPageState(category);
}

class CardPageState extends State<CardPage> {
  String category;
  CardPageState(String category) {
    this.category = category.replaceAll('.', ".\n").replaceAll(",", ",\n");
    if (this.category.contains(",\n and")) {
      this.category = this.category.replaceAll("and", "and\n");
    }
  }

  GlobalKey _globalKey = new GlobalKey();

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
    print("Payload : " + payload);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
    );

  }

  Future<void> _captureQuotePicAndShare() async {
    return new Future.delayed(const Duration(milliseconds: 0), () async {
      try {
        RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        await Share.file('Quote Image', 'quote.png', byteData.buffer.asUint8List(), 'image/png');
      } catch (e) {
        print(e);
      }
    });
  }

//  Future<Uint8List> _capturePng() async {
//    return new Future.delayed(const Duration(milliseconds: 0), () async {
//      try {
//        RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
//        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//        ByteData byteData =
//        await image.toByteData(format: ui.ImageByteFormat.png);
//        Uint8List pngBytes = byteData.buffer.asUint8List();
//        return pngBytes;
//      } catch (e) {
//        print(e);
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: _globalKey,
        child: new Scaffold(
          body: new Container(
              color: Colors.black,
              //margin: new EdgeInsets.fromLTRB(30, 30, 30, 200),
              padding: new EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                      color: Colors.black,
                      child: RichText(
                        text: TextSpan(
                            text: category,
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Stylish",
                                color: Colors.pinkAccent)),
                        textAlign: TextAlign.center,
                      )),


                ],
              )),
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
          tooltip: 'Increment',
          icon: Icon(Icons.share),
          onPressed: _captureQuotePicAndShare,
          label: new Text("Share")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
