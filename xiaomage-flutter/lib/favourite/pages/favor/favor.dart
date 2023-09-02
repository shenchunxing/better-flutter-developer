import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/pages/favor/favor_content.dart';

class HYFavorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body:HYFavorContent(),
    );
  }
}
