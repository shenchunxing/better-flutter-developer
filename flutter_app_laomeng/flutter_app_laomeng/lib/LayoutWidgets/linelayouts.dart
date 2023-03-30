import 'package:flutter/material.dart';

class LineLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return lineLayouts();
  }

  Widget lineLayouts() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 100,
                color: Colors.red,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.green,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.blue,
              ),
            ],
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50,
                width: 100,
                color: Colors.red,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.green,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.blue,
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),//边框
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red,
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.green,
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
              mainAxisSize: MainAxisSize.min, //默认是max，尽可能大Z(居左)，设置min会居中
              crossAxisAlignment: CrossAxisAlignment.center,//交叉轴居中
              textDirection: TextDirection.rtl, //布局方向
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red,
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                ),
                Container(
                  height: 150,
                  width: 100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          //verticalDirection 表示子组件交叉轴布局方向
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,//up ：从底部开始，并垂直堆叠到顶部，对齐方式的 start 在底部，end 在顶部
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red,
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                ),
                Container(
                  height: 150,
                  width: 100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
