import 'package:flutter/material.dart';

class ThemeBloc extends ChangeNotifier {
  List<Color> backgroundColors = [Colors.black, Colors.white, Colors.limeAccent];

  List<Color> fontColors = [
    Colors.pinkAccent,
    Colors.black,
    Colors.white,
    Colors.blueAccent,
    Colors.brown,
    Colors.deepPurple
  ];

  int backgroundColorIndex = 0;
  int fontColorIndex = 2;

  Color _backgroundColor = Colors.black;
  Color _fontColor = Colors.white;

  Color get backgroundColor => _backgroundColor;
  Color get fontColor => _fontColor;

  void setBackgroundColor(Color backgroundColor) {
    _backgroundColor = backgroundColor;
    notifyListeners();
  }

  void setFontColor(Color fontColor) {
    _fontColor = fontColor;
    notifyListeners();
  }

  void changeBackgroundColor() {
    backgroundColorIndex++;

    if (backgroundColorIndex >= backgroundColors.length) {
      backgroundColorIndex = 0;
    }

    _backgroundColor = backgroundColors.elementAt(backgroundColorIndex);

    if (fontColors.elementAt(fontColorIndex) ==
        backgroundColors.elementAt(backgroundColorIndex)) {
      changeFontColor();
    } else {
      notifyListeners();
    }
  }

  void changeFontColor() {
    fontColorIndex++;
    if (fontColorIndex == fontColors.length) {
      fontColorIndex = 0;
    }

    if (fontColors.elementAt(fontColorIndex) ==
        backgroundColors.elementAt(backgroundColorIndex)) {
      fontColorIndex++;
      if (fontColorIndex == fontColors.length) {
        fontColorIndex = 0;
      }
    }

    _fontColor = fontColors.elementAt(fontColorIndex);
    notifyListeners();
  }
}
