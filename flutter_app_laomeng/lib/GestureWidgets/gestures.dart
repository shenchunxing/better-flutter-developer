import 'package:flutter/material.dart';

class Gestures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            children: [
              GestureDetector(
                onTapDown: (TapDownDetails tapDownDetails) {
                  print('onTapDown');
                },
                onTapUp: (TapUpDetails tapUpDetails) {
                  print('onTapUp');
                },
                onTap: () {
                  print('onTap');
                },
                onTapCancel: () {
                  print('onTapCancel');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),

              //双击
              GestureDetector(
                onDoubleTap: ()=>print('onDoubleTap'),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
              ),

              //长按
              GestureDetector(
                onLongPressStart: (v) => print('onLongPressStart'),
                onLongPressMoveUpdate: (v) => print('onLongPressMoveUpdate'),
                onLongPressUp: () => print('onLongPressUp'),
                onLongPressEnd: (v) => print('onLongPressEnd'),
                onLongPress: () => print('onLongPress'),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),

              //水平/竖直拖拽
              GestureDetector(
                onVerticalDragStart: (v) => print('onVerticalDragStart'),
                onVerticalDragDown: (v) => print('onVerticalDragDown'),
                onVerticalDragUpdate: (v) => print('onVerticalDragUpdate'),
                onVerticalDragCancel: () => print('onVerticalDragCancel'),
                onVerticalDragEnd: (v) => print('onVerticalDragEnd'),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),

              //缩放
              GestureDetector(
                onScaleStart: (v) => print('onScaleStart'),
                onScaleUpdate: (ScaleUpdateDetails v) => print('onScaleUpdate'),
                onScaleEnd: (v) => print('onScaleEnd'),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.purple,
                ),
              ),
            ],
          ),

          //InkWell 组件在用户点击时出现“水波纹”效果
          InkWell(
            onTap: (){},
            splashColor: Colors.red,
            highlightColor: Colors.blue,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                //给字体添加边距和圆角边框，扩大“水波纹”效果,发现“水波纹”超出的了圆角边框
                decoration: BoxDecoration(
                    border:Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text('这是InkWell点击效果')
            ),
          ),

          //Ink控件用于在[Material]控件上绘制图像和其他装饰，以便[InkWell]、[InkResponse]控件的“水波纹”效果在其上面显示,不会超过圆角边框
          Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDE2F21), Color(0xFFEC592F)]),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(
                  '这是InkWell的点击效果',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {},
            ),
          ),

          //Listener 是一个监听指针事件的控件，比如按下、移动、释放、取消等指针事件，但Listener无法监听鼠标特有的事件，比如：移入、悬停、移出事件。鼠标事件使用MouseRegion监听。
          //通常情况下，监听手势事件使用GestureDetector，GestureDetector是更高级的手势事件
          Listener(
            onPointerDown: (PointerDownEvent pointerDownEvent) {
              print('$pointerDownEvent');
            },
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              print('$pointerMoveEvent');
            },
            onPointerUp: (PointerUpEvent upEvent) {
              print('$upEvent');
            },
            child: Container(
              height: 200,
              width: 200,
              color: Colors.blue,
              alignment: Alignment.center,
            ),
          ),

          SizedBox(height: 50,),
          ButtonCase(), //进度按钮
        ],
      ),
    );
  }
}

class ButtonCase extends StatefulWidget {
  @override
  _ButtonCaseState createState() => _ButtonCaseState();
}

class _ButtonCaseState extends State<ButtonCase> {
  ButtonStatus _buttonStatus = ButtonStatus.none;

  _buildChild() {
    if (_buttonStatus == ButtonStatus.none) {
      return Text(
        '登 录',
        style: TextStyle(color: Colors.white,fontSize: 18),
      );
    } else if (_buttonStatus == ButtonStatus.loading) {
      return CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 2,
      );
    } else if (_buttonStatus == ButtonStatus.done) {
      return Icon(
        Icons.check,
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      minWidth: 240,
      height: 48,
      onPressed: () {
        setState(() {
          _buttonStatus = ButtonStatus.loading;
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _buttonStatus = ButtonStatus.done;
            });
          });
        });
      },
      child: _buildChild(),
    );
  }
}

enum ButtonStatus { none, loading, done }




