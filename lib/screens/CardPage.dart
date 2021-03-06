import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:daily_quotes/bloc/font_bloc.dart';
import 'package:daily_quotes/bloc/text_bloc.dart';
import 'package:daily_quotes/bloc/color_bloc.dart';
import 'package:daily_quotes/screens/EditQuote.dart';


//APPID: ca-app-pub-7289797869104916~5923321156
//Next steps
//Make a note of your new app ID. You'll need to add it to your app's source code to run AdMob.
//Create an ad unit to display ads in your app.
//If your app is published to Google Play or the App Store, remember to come back to link your app.


import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class CardPage extends StatefulWidget {

  @override
  CardPageState createState() => CardPageState();
}

class CardPageState extends State<CardPage> {

  GlobalKey _globalKey = new GlobalKey();

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


  @override
  Widget build(BuildContext context) {

    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final TextBloc textBloc = Provider.of<TextBloc>(context);
    final FontBloc fontBloc = Provider.of<FontBloc>(context);

    return new Scaffold(
      body: new RepaintBoundary(
          key: _globalKey,
          child: new Scaffold(
            body: new Container(
                color: themeBloc.backgroundColor,
                padding: new EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: textBloc.statusText,
                          style: TextStyle(
                              fontSize: textBloc.fontSize,
                              fontFamily: fontBloc.fontName,
                              color: themeBloc.fontColor)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            ),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _captureQuotePicAndShare,
        tooltip: 'Share',
        child: Icon(Icons.share),
        elevation: 2.0,
        backgroundColor: themeBloc.fontColor,
        foregroundColor: themeBloc.backgroundColor,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: themeBloc.backgroundColor,
            primaryColor: themeBloc.fontColor,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: themeBloc.fontColor))),
        child: getBottomNavigationBar(themeBloc, textBloc, fontBloc),
      ),
    );
  }

  BottomNavigationBar getBottomNavigationBar(ThemeBloc themeBloc, TextBloc textBloc, FontBloc fontBloc){
    return new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int i) => bottomBarOperations(i, themeBloc, textBloc, fontBloc),
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.format_color_fill),
            title: new Text(""),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.format_color_text),
            title: new Text(""),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.format_size),
            title: new Text(""),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.font_download),
            title: new Text(""),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.title),
            title: new Text(""),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.edit),
            title: new Text(""),
          )
        ]);
  }
  void bottomBarOperations(int i, ThemeBloc themeBloc, TextBloc textBloc, FontBloc fontBloc) {
    if (i == 0)
      themeBloc.changeBackgroundColor();
    else if (i == 1)
      themeBloc.changeFontColor();
    else if(i==2) {
      textBloc.changeFontSize();
    }
    else if(i==3) {
      fontBloc.changeFont();
    }
    else if(i==4) {
      textBloc.changeCase();
    }
    else
      editText();
  }

  void editText() {
    Navigator.push(
        context,
        MaterialPageRoute<DismissDialogAction>(
          builder: (BuildContext context) => EditQuote(),
          fullscreenDialog: true,
        ));
  }
}
