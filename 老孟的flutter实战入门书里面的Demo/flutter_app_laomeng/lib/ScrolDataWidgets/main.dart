import 'package:flutter/material.dart';
import 'listviews.dart';
import 'gridviews.dart';
import 'pageviews.dart';
import 'datatables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Demo"),),
        body: ListViews(),
      ),
    );
  }
}
