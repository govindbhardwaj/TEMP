import 'package:daily_quotes/dto/QuotesDTO.dart';
import 'package:daily_quotes/screens/CardPage.dart';
import 'package:flutter/material.dart';

class QuotesPage extends StatefulWidget {
  String category;
  QuotesPage(this.category);

  @override
  QuotePageState createState() => QuotePageState(category);
}

class QuotePageState extends State<QuotesPage> {
  String category;
  QuotePageState(this.category);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(category),
        ),
        body: new FutureBuilder<QuotesDTO>(
          future: loadQuotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new ListView.builder(
                    itemBuilder: (context, position) {
                      const textStyle = const TextStyle(color: Colors.pink);
                      return Card(
                        child: ListTile(
                          leading: new Icon(
                            Icons.chevron_left,
                            color: Colors.pink.shade900,
                          ),
                          title:
                              Text(snapshot.data.map[category][position].quote),
                          subtitle: Text(
                            snapshot.data.map[category][position].author + " -",
                            style: textStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          trailing: new Icon(
                            Icons.format_quote,
                            color: Colors.pink.shade900,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CardPage(snapshot
                                        .data.map[category][position].quote)));
                          },
                        ),
                      );
                    },
                    itemCount: snapshot.data.map[category].length,
                  ));
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}
