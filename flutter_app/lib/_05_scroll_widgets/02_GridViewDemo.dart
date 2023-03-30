import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(GridViewApp());
}

class GridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'Flutter Demo',
       theme: ThemeData(primarySwatch: Colors.blue,splashColor: Colors.transparent), //主题
       home: GridViewContent(),
    );
  }
}

class GridViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('瀑布流'),),
      body: GridViewDemo2(),
    );
  }
}

class GridViewDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //每行3个
        childAspectRatio: 0.5,//宽度/高度 = 0。5
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      children: List.generate(100, (index) {
        return Container(
          color: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),
        );
      }),
    );
  }
}

class GridViewDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 300,//固定最大宽度：每行个数不固定，只是一个大概值
      crossAxisSpacing: 8,//交叉轴间距
      mainAxisSpacing: 8, //主轴间距
      childAspectRatio: 2.8,//长宽比例
    ),
      children: List.generate(100, (index) {
    return Container(
    color: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),
    );
    }));
  }
}

class GridViewDemo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0), //水平方向间距为0
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //行数固定，宽度不固定
          mainAxisSpacing: 8,//主轴间距
          crossAxisSpacing: 14,//交叉轴间距
        ),itemBuilder: (BuildContext context , int index) {
          return Container(color: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),);
        },),
    );
  }
}
