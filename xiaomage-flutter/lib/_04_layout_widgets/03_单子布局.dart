import 'package:flutter/material.dart';

void main() {
  runApp(SingleApp());
}

class SingleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlignDemo(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('基础widget'),),
      body: AlignDemo(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => print('floatingActionButton clicked'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //悬浮按钮的位置
    );
  }
}

class HYHomeContent extends StatefulWidget {
  @override
  _HYHomeContentState createState() => _HYHomeContentState();
}

class _HYHomeContentState extends State<HYHomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment(0,0),
      padding: EdgeInsets.all(20),//内边距:子视图距离父视图的位置
      margin: EdgeInsets.all(40), //外边距：父视图距离外面的位置
      child: Text('hello world'),
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 5,color: Colors.purple), //边框
        boxShadow: [ //阴影
          BoxShadow(color: Colors.orange,offset: Offset(10,10),spreadRadius: 5,blurRadius: 10),//右下
          BoxShadow(color: Colors.blue,offset: Offset(-10,-10),spreadRadius: 5,blurRadius: 10),//左上
        ],
      ),
    );
  }
}

class PaddingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 140, 0, 0),
      child: Text("你好啊，李银河",style: TextStyle(fontSize: 30,color: Colors.white,backgroundColor: Colors.red),),
    );
  }
}

class AlignDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.5,0.5),
      widthFactor: 5,
      heightFactor: 5,
      child: Icon(Icons.pets,size: 50,color: Colors.red,),
    );
  }
}
