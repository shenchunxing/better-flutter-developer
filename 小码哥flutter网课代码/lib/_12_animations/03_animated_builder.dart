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

/**
 *  1.Animation: 抽象类
 *    * 监听动画值的改变
 *    * 监听动画状态的改变
 *    * value
 *    * status
 *  2.AnimationController继承自Animation
 *    * vsync: 同步信号(this -> with SingleTickerProviderStateMixin)
 *    * forward(): 向前执行动画
 *    * reverse(): 反转执行动画
 *  3.CurvedAnimation:
 *    * 作用: 设置动画执行的速率(速度曲线)
 *  4.Tween: 设置动画执行的value范围
 *    * begin: 开始值
 *    * end: 结束值
 */
class _HYHomePageState extends State<HYHomePage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  Animation<double>? _animation;
  Animation? _sizeAnim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 1.创建AnimationController
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)//动画时间
    );

    // 2.设置Curve的值
    //curve：动画类型
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    // 3.Tween
    //设置动画最小和最大的尺寸
    _sizeAnim = Tween<double>(begin: 50,end: 150).animate(_animation!);
    // 监听动画值的改变
    _controller.addListener(() {
      setState(() {

      });
    });

    // 监听动画的状态改变
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
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body: Center(
        //动画构建器
        child: AnimatedBuilder(
          animation: _controller,
          builder: (ctx , child) {
            return Icon(Icons.favorite,color: Colors.red,size: _sizeAnim?.value,);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          if (_controller.isAnimating) { //正在动画
            _controller.stop(); //暂停
            print(_controller.status);
          } else if (_controller.status == AnimationStatus.forward) {
            _controller.forward(); //正向
          } else if (_controller.status == AnimationStatus.reverse) {
            _controller.reverse();//反向
          } else {
            _controller.forward();//默认正向
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();//销毁控制器
    // TODO: implement dispose
    super.dispose();
  }
}