import 'package:daily_quotes/screens/QuotesPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Daily Quote'),
        ),
        body: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                  child: ListTile(
                    leading: new Icon(Icons.bookmark_border),
                    title: Text(quotesCategory[position]),
                    trailing: const Icon(Icons.format_quote),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuotesPage(quotesCategory[position])));
                    },
                  ),
                );
              },
              itemCount: quotesCategory.length,
            )));
  }
}
