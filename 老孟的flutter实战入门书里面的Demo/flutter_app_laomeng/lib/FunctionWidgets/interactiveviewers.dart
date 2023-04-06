import 'package:flutter/material.dart';

//InteractiveViewer 是 Flutter 1.20 新增的组件，用户可以通过拖动以平移、缩放和拖放子组件
class InteractiveViewers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InteractiveViewer(
          alignPanAxis: true,//alignPanAxis 参数表示是否只在水平和垂直方向上拖拽，默认为false，设置为true，无法沿着对角线（斜着）方向移动
          maxScale: 2,
          minScale: 1,
          scaleEnabled: true,
          child: Image.asset('assets/images/aa.jpg'),
        ),
      ],
    );
  }
}

class InteractiveViewerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const int _rowCount = 20;
    const int _columnCount = 10;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: InteractiveViewer(
            //当用户开始平移或缩放手势时调用。
            onInteractionStart: (ScaleStartDetails scaleStartDetails){
              print('onInteractionStart:$scaleStartDetails');
            },
            //当用户更新组件上的平移或缩放手势时调用。
            onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
              print('onInteractionUpdate:$scaleUpdateDetails');
            },
            //当用户在组件上结束平移或缩放手势时调用。
            onInteractionEnd: (ScaleEndDetails endDetails){
              print('onInteractionEnd:$endDetails');
            },
            constrained: false,//子组件为 Table，Table 尺寸大于屏幕，必须将constrained设置为 false 以便将其绘制为完整尺寸。超出的屏幕尺寸可以平移到视图中
            child: Table(
              columnWidths: <int, TableColumnWidth>{
                for (int column = 0; column < _columnCount; column += 1)
                  column: const FixedColumnWidth(100.0),
              },
              children: <TableRow>[
                for (int row = 0; row < _rowCount; row += 1)
                  TableRow(
                    children: <Widget>[
                      for (int column = 0; column < _columnCount; column += 1)
                        Container(
                          height: 50,
                          color: row % 2 + column % 2 == 1
                              ? Colors.red
                              : Colors.green,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

