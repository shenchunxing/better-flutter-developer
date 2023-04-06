import 'package:flutter/material.dart';

void main() {
  runApp(ListViewApp());
}

class ListViewApp extends StatelessWidget {
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
      appBar: AppBar(
        title: Text('列表测试'),
      ),
      body: ListViewDemo3(),
    );
  }
}

class ListViewDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.separated(itemBuilder: (BuildContext context, int index) { //带分割线的list
        return Text('hello world: $index',style: TextStyle(fontSize: 20),); //主体
      }, separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.red,height: 10,indent: 10,endIndent: 10,thickness: 2,); //分割线
      }, itemCount: 100),
    );
  }
}


class ListViewDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder( //自定义list
      itemCount: 100,
      itemExtent: 60,
        itemBuilder: (BuildContext context , int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text('Hello World ios Android JAVA Python: $index',style: TextStyle(fontSize: 20),),
          );
        },
    );
  }
}

class ListViewDemo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView( //固定count的list
       scrollDirection: Axis.vertical, //滚动方向
      reverse: false, //反向
      itemExtent: 60,
      children: List.generate(100, (index)  {
        return ListTile(
          leading: Icon(Icons.people),//左侧图标
      trailing: Icon(Icons.delete), //右侧图标
      title: Text('联系人${index + 1}'),
      subtitle: Text('电话号码:1111111'),
      );
      }),
    );
  }
}
