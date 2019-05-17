import 'package:daily_quotes/state/MyHomePage.dart';
import 'package:flutter/material.dart';
import '../dto/AllQuotes.dart';

class SecondPage extends StatefulWidget {
  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<SecondPage> {
  Widget futureWidget() {
    return new FutureBuilder<AllQuotes>(
      future: loadQuotes(),
      builder: (context, snapshot) {
        return new Container(
            padding: new EdgeInsets.all(20.0),
            child: new ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                  child: ListTile(
                    leading: FlutterLogo(),
                    title:
                        Text(snapshot.data.motivationalQuotes[position].quote),
                    subtitle: Text(
                      snapshot.data.motivationalQuotes[position].author + " -",
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: const Icon(Icons.format_quote),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                );
              },
              itemCount: snapshot.data.motivationalQuotes.length,
            ));
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
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
