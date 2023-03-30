import 'dart:math';

import 'package:flutter/material.dart';

/**
 * 颜色不变化，但是数据向上移动了
 * 这是因为在删除第一条数据的时候，Widget对应的Element并没有改变；
 * 而Element中对应的State引用也没有发生改变；
 * 在更新Widget的时候，Widget使用了没有改变的Element中的State；
 */
class ListItemFul extends StatefulWidget {
  final String name;

  /**
   * 我们理想中的效果：
      因为这是在更新widget的过程中根据key进行了diff算法
      在前后进行对比时，发现bbb对应的Element和ccc对应的Element会继续使用，那么就会删除之前aaa对应的Element，而不是直接删除最后一个Element
   */
  ListItemFul(this.name, Key key):super(key: key);

  @override
  _ListItemFulState createState() => _ListItemFulState();
}

class _ListItemFulState extends State<ListItemFul> {
  final Color randomColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Text(widget.name),
      color: randomColor,
    );
  }
}
