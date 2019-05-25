import 'package:flutter/material.dart';

class TextBloc extends ChangeNotifier {
  String _statusText = "What's your status";
  List<String> caseList;


  TextBloc(){
   caseList = [_statusText, _statusText.toLowerCase(), _statusText.toUpperCase()];
  }

  double _fontSize = 20;

  String get statusText => _statusText;

  void setStatusText (String statusText) {
    this._statusText = statusText.replaceAll('.', "\n")
        .replaceAll(",", "\n")
        .replaceAll(";", "\n");
    if (this._statusText.contains(",\n and")) {
      this._statusText = this._statusText.replaceAll("and", "and\n");
    }
    caseList = [_statusText, _statusText.toLowerCase(), _statusText.toUpperCase()];
    notifyListeners();
  }

  double get fontSize => _fontSize;

  void setFontSize (double fontSize) {
    this._fontSize = fontSize;
    notifyListeners();
  }

  int fontSizeIndex = 0;


  List<double> fontSizes = [20, 30, 40 ,50, 60];
  void changeFontSize () {
    fontSizeIndex++;
    if(fontSizeIndex == fontSizes.length) {
      fontSizeIndex = 0;
    }
    _fontSize = fontSizes.elementAt(fontSizeIndex);
    notifyListeners();
  }

  int caseIndex = 0;

  void changeCase() {
    caseIndex++;
    if(caseIndex == caseList.length) {
      caseIndex = 0;
    }
    print("called change case " + caseList.elementAt(caseIndex));
    _statusText = caseList.elementAt(caseIndex);
    notifyListeners();
  }
}
