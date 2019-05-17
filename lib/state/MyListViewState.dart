import 'package:flutter/material.dart';
import '../dto/AllQuotes.dart';

class MyApp extends StatefulWidget {
  MyApp();
  @override
  MyListViewState createState() => MyListViewState();
}

class MyListViewState extends State<MyApp> {
  Widget futureWidget() {
    return new FutureBuilder<AllQuotes>(
      future: loadQuotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
              padding: new EdgeInsets.all(20.0),
              child: new ListView(
                children: const <Widget>[
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text('One-line with leading widget'),
                    ),
                  )
                ],
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