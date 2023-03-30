import 'package:flutter/material.dart';

/**
 * 大部分情况下，不会使用到 Flow ，但 Flow 可以调整子组件的位置和大小，结合Matrix4绘制出各种酷炫的效果。
    Flow 组件对使用转换矩阵操作子组件经过系统优化，性能非常高效
 */
class CustomLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: SimpleFlowDelegate(),
      children: List.generate(5, (index) {
        return Container(
          height: 100,
          color: Colors.primaries[index % Colors.primaries.length],
        );
      }),
    );
  }
}

class SimpleFlowDelegate extends FlowDelegate {
  //绘制子视图
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; ++i) {
      context.paintChild(i,transform: Matrix4.translationValues(0,i*30.0,0));//偏移
    }
  }

  //是否需要重绘
  @override
  bool shouldRepaint(SimpleFlowDelegate oldDelegate) {
    return false;
  }
}


