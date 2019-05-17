import 'package:flutter/material.dart';
import '../dto/AllQuotes.dart';
import '../state/QuoteList.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyHomePage> {
  List<String> quotesCategory = [
    "Inspirational Quotes",
    "Motivational Quotes",
    "Positive Quotes",
    "Success Quotes",
    "Inspirational Quotes About Life",
    "Short Inspirational Quotes",
    "Words Of Encouragement",
    "Inspirational Quotes For Encouragement",
    "Short Encouraging Quotes",
    "Positive Encouraging Quotes"
  ];

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
                    title: Text(quotesCategory[position]),
                    trailing: const Icon(Icons.format_quote),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage()));
                    },
                  ),
                );
              },
              itemCount: quotesCategory.length,
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
