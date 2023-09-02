import 'package:flutter/material.dart';

void main () {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluter demo',
      theme: ThemeData(
        primaryColor: Colors.blue,splashColor: Colors.transparent
 ,     ),
      home: ListenerDemo(),
    );
  }
}

//内外手势监听
class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('列表测试'),),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTapDown: (details) {
                print("outer click");
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.yellow,
                alignment: Alignment.center,
              ),
            ),
            GestureDetector(
              onTapDown: (detail) {
                print("inner click");
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//手势
class GestureDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (details) {
          print("手指按下");
          print(details.localPosition); //针对父视图
          print(details.globalPosition);//针对坐标系
        },
        onTapUp: (details) {
          print("手指抬起");
        },
        onTapCancel: () {
          print("手势取消");
        },
        onTap: () {
          print("手势点击");
        },
        onDoubleTap: () {
          print("手指双击");
        },
        onLongPress: () {
          print("长按手势");
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orange,
        ),
      ),
    );
  }
}

//指针
class ListenerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener( //监听指针
      onPointerDown: (event) {
        print("指针按下:$event");
        print(event.position);
        print(event.localPosition);
      },
      onPointerMove: (event) {
        print('指针移动:$event');
      },
      onPointerUp: (event) {
        print('指针抬起:$event');
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
