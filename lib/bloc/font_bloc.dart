import 'package:flutter/material.dart';

class FontBloc extends ChangeNotifier {
  String _fontName= "Open_Sans";

  List<String> fonts = [
    "Stylish",
    "Tangerine",
    "JosefinSlab",
    "Ubuntu",
    "OpenSans",
    "Pacifico",
    "Damion",
    "Prata",
    "AmaticSC",
    "Quicksand",
    "PlayfairDisplay",
    "Montserrat",
    "GreatVibes",
    "Lobster",
    "Nunito",
    "MontserratAlternates",
    "JuliusSansOne",
    "Cinzel",
    "PlayfairDisplaySC",
    "RobotoSlab",
    "Mandali"
  ];

  String get fontName => _fontName;

  int fontIndex = 0;

  void changeFont() {
    fontIndex++;

    if (fontIndex == fonts.length) {
      fontIndex = 0;
    }

    print(fonts.elementAt(fontIndex));
    _fontName = fonts.elementAt(fontIndex);
    notifyListeners();
  }
}
