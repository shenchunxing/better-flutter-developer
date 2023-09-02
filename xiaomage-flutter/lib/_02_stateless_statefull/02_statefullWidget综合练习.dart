import 'package:flutter/material.dart';

void main() {
  runApp(StfApp());
}

class StfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品列表'),),
      body: HYHomeContent("你好啊，李银河"),
    );
  }
}
// Widget是不加_: 暴露给别人使用
class HYHomeContent extends StatefulWidget {
  final String message; //外部传入的字段message

  HYHomeContent(this.message);

  @override
  _HYHomeContentState createState() => _HYHomeContentState();
}


/**
 * 为什么Flutter在设计的时候StatefulWidget的build方法放在State中
 *  1.build出来的Widget是需要依赖State中的变量(状态/数据)
 *  2.在Flutter的运行过程中:
 *    Widget是不断的销毁和创建的
 *    当我们自己的状态发生改变时, 并不希望重新状态一个新的State
 */
// State是加_: 状态这个类只是给Widget使用
class _HYHomeContentState extends State<HYHomeContent> {
  int _counter = 0; //内部字段

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getButtons(),
          Text('当前计数:$_counter',style: TextStyle(fontSize: 25),),
          Text('传递的信息:${widget.message}'),
        ],
      ),
    );
  }

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text('+',style: TextStyle(fontSize: 20,color: Colors.white),),
          color: Colors.pink,
          onPressed: () {

            setState(() {
              _counter++;
            });
          },
        ),

        RaisedButton(
          child: Text('-',style: TextStyle(fontSize: 20,color: Colors.white),),
          color: Colors.pink,
          onPressed: () {

            setState(() {
              _counter--;
            });
          },
        ),
      ],
    );
  }
}

