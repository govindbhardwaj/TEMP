import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

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

  Future<void> _captureQuotePicAndShare() async {
    return new Future.delayed(const Duration(milliseconds: 0), () async {
      try {
        RenderRepaintBoundary boundary =
            _globalKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        await Share.file('Quote Image', 'quote.png',
            byteData.buffer.asUint8List(), 'image/png');
      } catch (e) {
        print(e);
      }
    });
  }

  List<Color> backgroundColors = [Colors.black, Colors.white, Colors.purple, Colors.grey];
  List<Color> fontColors = [Colors.pinkAccent, Colors.black, Colors.white, Colors.yellow, Colors.brown, Colors.deepPurple];

  int backgroundColorIndex = 0;
  int fontColorIndex = 0;

  Color getBackgroundColor() {
    if(backgroundColorIndex == backgroundColors.length || backgroundColorIndex > backgroundColors.length)
      backgroundColorIndex = 0;
    return backgroundColors.elementAt(backgroundColorIndex);
  }

  Color getFontColor() {
    if(fontColorIndex == fontColors.length || fontColorIndex > fontColors.length)
      fontColorIndex = 0;
    return fontColors.elementAt(fontColorIndex);
  }


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: new Scaffold(
          body: new RepaintBoundary(
            key: _globalKey,
            child: new Scaffold(
              body: new Container(
                  color: getBackgroundColor(),
                  padding: new EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: category,
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Stylish",
                                color: getFontColor())),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              tooltip: 'Increment',
              icon: Icon(Icons.share),
              onPressed: _captureQuotePicAndShare,
              label: new Text("Share")),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
        onTap: changeBackgroundColor,
        onDoubleTap: changeFontColor,
    );
  }

  void changeBackgroundColor() {
    backgroundColorIndex++;
    setState(() {
    });
  }

  void changeFontColor() {
    fontColorIndex++;
    setState(() {
    });
  }
}
