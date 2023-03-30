import 'package:flutter/material.dart';

//虚线
class HYDashedLine extends StatelessWidget {
  final Axis axis; //方向
  final double dashedWidth;//宽
  final double dashedHeight;//高
  final int count;//数量
  final Color color;//颜色
  
  HYDashedLine({
    @required this.axis = Axis.horizontal,
    this.dashedWidth = 1,
    this.dashedHeight = 1,
    this.count = 0,
    this.color = const Color(0xffff0000)
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context , BoxConstraints constraints){
      //等间距
      return Flex(direction: this.axis,mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
        List.generate(this.count, (int index) {
          return SizedBox(
            width: dashedWidth,
            height: dashedHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        }),
      );
    },);
  }
}
