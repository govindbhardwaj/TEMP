import 'package:daily_quotes/screens/CategoryPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes',
      
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: CategoryPage(),
    );
  }
}