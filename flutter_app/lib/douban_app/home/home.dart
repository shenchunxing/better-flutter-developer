import 'package:flutter/material.dart';
import 'package:flutter_app/douban_app/home/home_content.dart';

const COUNT = 20;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body: HomeContent(),
    );
  }
}
