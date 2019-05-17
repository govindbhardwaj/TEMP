import 'package:flutter/material.dart';
import '../dto/Student.dart';

class MyApp extends StatefulWidget {
  MyApp();
  @override
  MyListViewState createState() => MyListViewState();
}

class MyListViewState extends State<MyApp> {
  Widget futureWidget() {
    return new FutureBuilder<Student>(
      future: loadStudent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
              padding: new EdgeInsets.all(20.0),
              child: new ListView(
                children: const <Widget>[
                  Card(child: ListTile(title: Text('One-line ListTile'))),
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text('One-line with leading widget'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('One-line with trailing widget'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text('One-line with both widgets'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('One-line dense ListTile'),
                      dense: true,
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(size: 56.0),
                      title: Text('Two-line ListTile'),
                      subtitle: Text('Here is a second line'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(size: 72.0),
                      title: Text('Three-line ListTile'),
                      subtitle: Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      trailing: Icon(Icons.more_vert),
                      isThreeLine: true,
                    ),
                  ),
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