import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(CustomScrollViewApp());
}


class CustomScrollViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomScrollContent(),
    );
  }
}

class CustomScrollContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滚动视图'),),
      body: CustomScrollView1(),
    );
  }
}

//自定义listview
class CustomScrollView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
           //间距
            sliver: SliverPadding(
              padding: EdgeInsets.all(8),
              //布局参数
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                //单个内容
                delegate: SliverChildBuilderDelegate ( (BuildContext ctx , int index) {
                   return Container(
                       color: Color.fromARGB(255, Random().nextInt(
                           256), Random().nextInt(256), Random().nextInt(256))
                   );
                },
                    childCount: 100,
                ),
              ),
            ),
        ),
      ],
    );
  }
}

//联动listview
class CustomScrollView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //头部大图
        SliverAppBar(
          expandedHeight: 300,//头部高度
          pinned: false,
          flexibleSpace: FlexibleSpaceBar( //内容
            title: Text('hello world'), //文字
            background: Image.asset('assets/images/juren.jpeg',fit: BoxFit.cover,),//图片
          ),
        ),

        //瀑布流
        SliverGrid(
          //内容和数量
            delegate: SliverChildBuilderDelegate(childCount: 50, (BuildContext ctx , int index) {
              return Container(color: Color.fromARGB(255, Random().nextInt(
                  256), Random().nextInt(256), Random().nextInt(256)));
            },),
            //布局属性
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2
            ),
        ),
//
//        //列表
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//              childCount: 30,(BuildContext ctx , int index){
//            return ListTile(title: Text('联系人:$index'),leading: Icon(Icons.people),);
//          }),
//        ),
      ],
    );
  }
}
