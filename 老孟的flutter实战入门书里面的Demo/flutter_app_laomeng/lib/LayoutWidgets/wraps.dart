import 'package:flutter/material.dart';

class Wraps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return wrapsDemo();
  }

  Widget wrapsDemo() {
    return SingleChildScrollView(
        child: Column(
          children: [
            //Wrap 为子组件进行水平或者垂直方向布局，且当空间用完时，Wrap 会自动换行，也就是流式布局。
            Wrap(
              children: List.generate(10, (i) {
                double w = 50.0 + 10 * i;
                return Container(
                  color: Colors.primaries[i],
                  height: 50,
                  width: w,
                  child: Text('$i'),
                );
              }),
            ),


            Wrap(
              direction: Axis.vertical,//direction 属性控制布局方向，默认为水平方向
//              alignment: WrapAlignment.spaceBetween,//alignment 属性控制主轴对齐方式
              children: List.generate(4, (i) {
                double w = 50.0 + 10 * i;
                return Container(
                  color: Colors.primaries[i],
                  height: 50,
                  width: w,
                  child: Text('$i'),
                );
              }),
            ),

            Wrap(
              spacing: 5,//主轴间距
              runSpacing: 3,//交叉轴间距
              crossAxisAlignment: WrapCrossAlignment.end,
              textDirection: TextDirection.rtl, //右到左
              verticalDirection: VerticalDirection.up,//下到上
              children: List.generate(10, (i) {
                double w = 50.0 + 10 * i;
                double h = 50.0 + 5 * i;
                return Container(
                  color: Colors.primaries[i],
                  height: h,
                  alignment: Alignment.center,
                  width: w,
                  child: Text('$i'),
                );
              }),
            )


          ],
        ));
  }
}
