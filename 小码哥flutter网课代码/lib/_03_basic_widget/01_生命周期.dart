import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: HYHomeDemo(),
    );
  }
}

class HYHomeDemo extends StatefulWidget {
  @override
  _HYHomeDemoState createState() => _HYHomeDemoState();
}

class _HYHomeDemoState extends State<HYHomeDemo> {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Column(
        children: [
          HYHomeContent(),
        ],
      ),
    );
  }
}

/**
 *  冷启动
 *  flutter: build
    flutter: 1.调用HYHomeContent的constructor方法
    flutter: 2.调用HYHomeContent的createState方法
    flutter: 3.调用_HYHomeContentState的constructor方法
    flutter: 4.调用_HYHomeContentState的initState方法
    flutter: 调用_HYHomeContentState的didChangeDependencies方法
    flutter: 5.调用_HYHomeContentState的build方法

    热重载的时候content需要重新创建，state不需要重新创建
    flutter: build
    flutter: 1.调用HYHomeContent的constructor方法
    flutter: didUpdateWidget
    flutter: 5.调用_HYHomeContentState的build方法
 */
class HYHomeContent extends StatefulWidget {
  HYHomeContent() {
    print('1.调用HYHomeContent的constructor方法');
  }

  @override
  _HYHomeContentState createState() {
    print('2.调用HYHomeContent的createState方法');
    return _HYHomeContentState();
  }
}

class _HYHomeContentState extends State<HYHomeContent> {
  int _counter = 0;

  _HYHomeContentState() {
     print("3.调用_HYHomeContentState的constructor方法");
  }

  @override
  void initState() {
    // TODO: implement initState
    final TextStyle style = TextStyle();
    super.initState();

    print("4.调用_HYHomeContentState的initState方法");
  }

  //父widget发生改变
  @override
  void didUpdateWidget(covariant HYHomeContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("调用_HYHomeContentState的didChangeDependencies方法");
  }

  @override
  Widget build(BuildContext context) {
    print("5.调用_HYHomeContentState的build方法");
    return Column(
      children: [
        RaisedButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
        ),

        Text('数字：$_counter'),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("6.调用_HYHomeContentState的dispose方法");
    super.dispose();
  }
}

