import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatefulWidget {
  @override
  _HYHomePageState createState() => _HYHomePageState();
}

//组合动画
class _HYHomePageState extends State<HYHomePage>
    with SingleTickerProviderStateMixin {
  // 创建AnimationController
   late AnimationController _controller;
   late Animation<double> _animation;
   late Animation _sizeAnim;
   late Animation _colorAnim;
   late Animation<double> _opacityAnim;
   late Animation<double> _radiansAnim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    //设置大小
    _sizeAnim = Tween(begin: 10.0,end: 200.0).animate(_controller);
    //颜色
    _colorAnim = ColorTween(begin: Colors.orange,end: Colors.purple).animate(_controller);
    //透明度
    _opacityAnim = Tween(begin: 0.0,end: 1.0).animate(_controller);
    //旋转弧度
    _radiansAnim = Tween(begin: 0.0,end: 2 * pi).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /**
     * 1.大小变化动画
     * 2.颜色变化动画
     * 3.透明度变化动画
     */
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (ctx , child) {
            return Opacity( //透明
              opacity: _opacityAnim.value, //透明度
              child: Transform( //旋转
                transform: Matrix4.rotationZ(_radiansAnim.value), //旋转
                alignment: Alignment.center,
                child: Container(
                  width: _sizeAnim.value,//大小
                  height: _sizeAnim.value,
                  color: _colorAnim.value,//颜色
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
            print(_controller.status);
          } else if (_controller.status == AnimationStatus.forward) {
            _controller.forward();
          } else if (_controller.status == AnimationStatus.reverse) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}