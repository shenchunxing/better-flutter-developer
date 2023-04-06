import 'dart:math';

import 'package:flutter/material.dart';

/**
 * 它的实现效果是每删除一个，所有的颜色都会发现一次变化
 * 原因非常简单，删除之后调用setState，会重新build，重新build出来的新的StatelessWidget会重新生成一个新的随机颜色
 */
class ListItemLess extends StatelessWidget {
  final String name;
  final Color randomColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));

  ListItemLess(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Text(name),
      color: randomColor,
    );
  }
}
