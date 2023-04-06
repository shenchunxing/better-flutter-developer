import 'package:flutter/material.dart';

class Drags extends StatefulWidget {
  @override
  State<Drags> createState() => _DragsState();
}

class _DragsState extends State<Drags> {
  var _dragData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Draggable(
            axis: Axis.vertical,
            //拖动方向
            onDragStarted: () {
              print('onDragStarted');
            },
            onDragEnd: (DraggableDetails details) {
              print('onDragEnd:$details');
            },
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              print('onDraggableCanceled velocity:$velocity,offset:$offset');
            },
            onDragCompleted: () {
              print('onDragCompleted');
            },
            child: Container( //底图
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                '孟', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
            childWhenDragging: Container( //childWhenDragging拖动时底图显示的样式
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Text(
                '孟',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            feedback: Container( //拖动图
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                '孟', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ),


          SizedBox(
            height: 50,
          ),
          _buildDraggable(),
          SizedBox(
            height: 200,
          ),
          //指定一个目的地，Draggable组件可以拖动到此控件
          DragTarget<Color>(
            builder: (context, candidateData,
                List<dynamic> rejectedData) {
              print('candidateData:$candidateData,rejectedData:$rejectedData');
              return _dragData == null
                  ? Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red)),
              )
                  : Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '孟',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
            onWillAccept: (color) { //拖到该控件上时调用，需要返回true或者false，返回true，松手后会回调onAccept，否则回调onLeave
              print('onWillAccept:$color');
              return true;
            },
            onAccept: (Color color) {//onWillAccept返回true时，用户松手后调用
              setState(() {
                _dragData = color;
              });
              print('onAccept:$color');
            },
            onLeave: (color) { //onWillAccept返回false时，用户松手后调用。
              print('onLeave:$color');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDraggable() {
    return Draggable(
      data: Color(0x000000FF),
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Text(
          '孟',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      feedback: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: Colors.white, fontSize: 18),
          child: Text(
            '孟',
          ),
        ),
      ),
    );
  }
}
