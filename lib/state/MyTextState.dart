import 'package:flutter/material.dart';
import '../dto/AllQuotes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyHomePage> {
  Widget futureWidget() {
    return new FutureBuilder<AllQuotes>(
      future: loadQuotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[Text("Hello")],
              ));
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Daily Quote'),
          ),
          body: futureWidget()),
    );
  }
}
