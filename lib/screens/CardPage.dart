import 'package:daily_quotes/screens/CategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardPage extends StatefulWidget {
  String category;
  CardPage(this.category);

  @override
  CardPageState createState() => CardPageState(category);
}

class CardPageState extends State<CardPage> {
  String category;
  CardPageState(String category) {
    this.category = category
        .replaceAll('.', ".\n")
        .replaceAll(",", ",\n");
    if(this.category.contains(",\n and")){
      this.category = this.category.replaceAll("and", "and\n");
    }
        
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> menu = <Widget>[
      new IconButton(
          icon: new Icon(Icons.image),
          tooltip: 'Home page',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryPage()));
          })
    ];

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Daily Quote'),
          actions: menu,
        ),
        // body: new Container(
        //   padding: new EdgeInsets.all(20.0),
        //   height: ,
        //   child:

        // ));
        body: new Container(
            color: Colors.black,
            //margin: new EdgeInsets.fromLTRB(30, 30, 30, 200),
            padding: new EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                    color: Colors.black,
                    child: RichText(
                      text: TextSpan(
                          text: category,
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: "Stylish",
                              color: Colors.pinkAccent)),
                      textAlign: TextAlign.center,
                    ))
              ],
            )));
  }
}
