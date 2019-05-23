import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

List<Color> backgroundColors = [Colors.black, Colors.white];

List<Color> fontColors = [
  Colors.pinkAccent,
  Colors.black,
  Colors.white,
  Colors.blueAccent,
  Colors.brown,
  Colors.deepPurple
];

int backgroundColorIndex = 0;
int fontColorIndex = 0;

class CardPage extends StatefulWidget {
  String category;
  CardPage(this.category);

  @override
  CardPageState createState() => CardPageState(category);
}

class CardPageState extends State<CardPage> {
  String category;
  CardPageState(String category) {
    this.category = category
        .replaceAll('.', "\n")
        .replaceAll(",", "\n")
        .replaceAll(";", "\n");
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

  void resetIndexes() {
    if (backgroundColorIndex == backgroundColors.length) {
      backgroundColorIndex = 0;
    }

    if (fontColorIndex == fontColors.length) {
      fontColorIndex = 0;
    }
  }

  Color getBackgroundColor() {
    resetIndexes();
    return backgroundColors.elementAt(backgroundColorIndex);
  }

  Color getFontColor() {
    resetIndexes();

    if (fontColors.elementAt(fontColorIndex) ==
        backgroundColors.elementAt(backgroundColorIndex)) {
      fontColorIndex++;
      resetIndexes();
    }
    return fontColors.elementAt(fontColorIndex);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RepaintBoundary(
        key: _globalKey,
        child: new Scaffold(
            body: new Dismissible(
          resizeDuration: null,
          onDismissed: (DismissDirection direction) {
            setState(() {
              backgroundColorIndex +=
                  direction == DismissDirection.endToStart ? 1 : -1;
            });
          },
          key: new ValueKey(backgroundColorIndex),
          child: new Container(
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
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _captureQuotePicAndShare,
        tooltip: 'Share',
        child: Icon(Icons.share),
        elevation: 2.0,
        backgroundColor: getFontColor(),
        foregroundColor: getBackgroundColor(),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: getBackgroundColor(),
            primaryColor: getFontColor(),
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(
                    color:
                        getFontColor()))),
        child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (int i) => doWhat(i),
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.color_lens),
                title: new Text(""),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.font_download),
                title: new Text(""),
              )
            ]),
      ),
    );
  }

  void changeBackgroundColor() {
    backgroundColorIndex++;
    setState(() {});
  }

  void changeFontColor() {
    fontColorIndex++;
    setState(() {});
  }

  void doWhat(int i) {
    if (i == 0)
      changeBackgroundColor();
    else
      changeFontColor();
  }
}
