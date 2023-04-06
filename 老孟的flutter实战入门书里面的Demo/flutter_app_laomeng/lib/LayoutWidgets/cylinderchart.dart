import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

//柱状图
class CylinderChart extends StatefulWidget {
  @override
  _CylinderChartState createState() => _CylinderChartState();
}

class _CylinderChartState extends State<CylinderChart> {
  final double _width = 20.0;
  List<double> _heightList = [60.0, 80.0, 100.0, 120.0, 140.0];

  @override
  Widget build(BuildContext context) {
    return Center( //居中
      child: Container(
        height: 200,
        width: 250,
        child: Stack(
          children: <Widget>[
            _Axis(),//坐标轴
            Positioned.fill( //fill：上下左右都是0
              left: 5, //距离坐标轴的左间距
              right: 5,//距离坐标轴的右间距
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,//底部对齐
                  children: List.generate(_heightList.length, (index) {
                    return _Cylinder(
                      height: _heightList[index],
                      width: _width,
                      color: Colors.primaries[index % Colors.primaries.length],
                    );
                  })),
            ),
            Positioned(
              top: 0,
              left: 30,
              child: OutlinedButton(
                child: Text('反转'),
                onPressed: () {
                  setState(() {
                    _heightList = _heightList.reversed.toList();//反转数组，重新build
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//单个柱状图
class _Cylinder extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const _Cylinder({Key? key,required this.height,required this.width,required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer( //动画
      duration: Duration(seconds: 1),
      height: height,
      width: width,
      color: color,
    );
  }
}

//坐标轴
class _Axis extends StatelessWidget {
  final Widget? child;
  const _Axis({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: 2),
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: child,
    );
  }
}

