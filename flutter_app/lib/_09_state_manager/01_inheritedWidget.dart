import 'package:flutter/material.dart';

void main () =>  runApp(MyApp());

class UserInfo {
  String? name;
  int? age;
}

//InheritedWidget:共享数据
class HYCounterWidget extends InheritedWidget {
  // 1.共享的数据
  final int? counter;
// 2.定义构造方法
  HYCounterWidget({this.counter, required Widget child}): super(child: child);
  // 3.获取组件最近的当前InheritedWidget
  static HYCounterWidget? of(BuildContext context) {
    // 沿着Element树, 去找到最近的HYCounterElement, 从Element中取出Widget对象
    return context.dependOnInheritedWidgetOfExactType();
  }

  // 4.决定要不要回调State中的didChangeDependencies
  // 如果返回true: 执行依赖当期的InheritedWidget的State中的didChangeDependencies
  @override
  bool updateShouldNotify(HYCounterWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.counter != counter;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primaryColor: Colors.blue,splashColor: Colors.transparent
      ),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatefulWidget {
  @override
  _HYHomePageState createState() => _HYHomePageState();
}

class _HYHomePageState extends State<HYHomePage> {
  int _counter = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('InheritedWidget'),),
      body: HYCounterWidget( //被HYCounterWidget包裹的子widget都可以共享数据
        counter: _counter, //共享counter
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HYShowData01(),
              HYShowData02(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
      ),
    );
  }
}

class HYShowData01 extends StatefulWidget {
  @override
  _HYShowData01State createState() => _HYShowData01State();
}

class _HYShowData01State extends State<HYShowData01> {
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("执行了_HYShowData01State中的didChangeDependencies");
  }
  
  @override
  Widget build(BuildContext context) {
    //获取组件最近的当前InheritedWidget
    int? counter = HYCounterWidget.of(context)!.counter;

    return Card( //Card有立体感的Container
      color: Colors.red,
      child: Text('当前计数: $counter',style: TextStyle(fontSize: 30),),
    );
  }
}

class HYShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int? counter = HYCounterWidget.of(context)!.counter;

    return Container(
      color: Colors.blue,
      child: Text("当前计数: $counter", style: TextStyle(fontSize: 30),),
    );
  }
}
