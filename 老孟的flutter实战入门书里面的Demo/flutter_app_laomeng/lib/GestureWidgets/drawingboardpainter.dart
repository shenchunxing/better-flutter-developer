import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<List<Offset>> _path = []; //存储路径

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent pointerDownEvent) { //按下
        setState(() {
          print("pointerDownEvent");
          _path.add([pointerDownEvent.localPosition]);
        });
      },
      onPointerMove: (PointerMoveEvent pointerMoveEvent) { //移动
        setState(() {
          print("pointerMoveEvent");
          _path[_path.length-1].add(pointerMoveEvent.localPosition);
        });
      },
      onPointerUp: (PointerUpEvent pointerUpEvent) { //抬起
        setState(() {
          print("pointerUpEvent");
          _path[_path.length-1].add(pointerUpEvent.localPosition);
        });
      },
      onPointerCancel: (PointerCancelEvent pointerCancelEvent) { //取消
        setState(() {
          print("pointerCancelEvent");
          _path[_path.length-1].add(pointerCancelEvent.localPosition);
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: DrawingBoardPainter(_path),
        ),
      ),
    );
  }
}

//绘画板
class DrawingBoardPainter extends CustomPainter {
  final List<List<Offset>> path;

  DrawingBoardPainter(this.path);

  Paint _paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  //绘制
  @override
  void paint(Canvas canvas, Size size) {
    path.forEach((list) {
      Path _path = Path();
      for (int i = 0; i < list.length; i++) {
        if (i == 0) {
          _path.moveTo(list[i].dx, list[i].dy);
        } else {
          _path.lineTo(list[i].dx, list[i].dy);
        }
      }
      canvas.drawPath( _path, _paint);
    });
  }

  @override
  bool shouldRepaint(DrawingBoardPainter oldDelegate) {
    return true;
  }
}