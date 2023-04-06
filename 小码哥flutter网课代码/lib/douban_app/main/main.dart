import 'package:flutter/material.dart';
import 'package:flutter_app/douban_app/main/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: ThemeData(primaryColor: Colors.green, splashColor: Colors.transparent,highlightColor: Colors.transparent),
      home: HYMainPage(),
    );
  }
}
