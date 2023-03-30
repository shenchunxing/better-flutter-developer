
import 'package:flutter/material.dart';

//自定义AppBar
class HYHomeAppBar extends AppBar {
  HYHomeAppBar(BuildContext context):super(
    title: Text('美食广场'),
    leading: Builder( //不包装builder可能导致侧边栏打不开
      builder: (ctx) {
        return IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              Scaffold.of(ctx).openDrawer(); //打开侧边栏
        });
      },
    ),
  );
}