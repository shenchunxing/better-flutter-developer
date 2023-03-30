
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/pages/home/home_app_bar.dart';
import 'package:flutter_app/favourite/pages/home/home_drawer.dart';
import 'home_content.dart';

class HYHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HYHomeAppBar(context),//导航
      body: HYHomeContent(),//主体
      drawer: HYHomeDrawer(),//侧边栏
    );
  }
}
