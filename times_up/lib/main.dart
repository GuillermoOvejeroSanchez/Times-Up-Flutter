import 'package:flutter/material.dart';
import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const Title = "Time's Up";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: Title),
    );
  }
}

