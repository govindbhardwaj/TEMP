import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daily_quotes/bloc/color_bloc.dart';
import 'package:daily_quotes/bloc/font_bloc.dart';
import 'package:daily_quotes/bloc/text_bloc.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class EditQuote extends StatefulWidget {
  @override
  EditQuoteState createState() => EditQuoteState();
}

class EditQuoteState extends State<EditQuote> {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final TextBloc textBloc = Provider.of<TextBloc>(context);
    final FontBloc fontBloc = Provider.of<FontBloc>(context);

    final myController = TextEditingController();
    myController.text = textBloc.statusText;

    return new Theme(
        data: new ThemeData(primaryColor: Colors.pink),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Quote', style: TextStyle(fontFamily: "Quicksand")),
              actions: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    textBloc.setStatusText(myController.text);
                    Navigator.pop(context, DismissDialogAction.save);
                  },
                ),
              ],
            ),
            body: Container(
              child: Form(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //const SizedBox(height: 24.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    color: Colors.pinkAccent,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  hintText: 'Share somthing you like',
                                  helperText:
                                      'Keep it short, this is just a demo.',
                                  labelText: "Status",
                                ),
                                controller: myController,
                                style: TextStyle(
                                    fontFamily: fontBloc.fontName,
                                    fontSize: 30),
                                maxLines: 10,
                                textInputAction: TextInputAction.newline,
                                textAlign: TextAlign.center,
                              ),
                            ]))
                  ].map<Widget>((Widget child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //height: 96.0,
                      child: child,
                    );
                  }).toList(),
                ),
              ),
            )));
  }
}
