import 'package:flutter/material.dart';

class Containers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Container(
              margin: EdgeInsets.all(10),//外边距
              padding: EdgeInsets.all(20),//内边距
              color: Colors.red,
              child: Text('老孟'),
            ),
          )
          ,
          Container(
            child: Text('老孟，专注分享Flutter技术及应用'),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          ),

          Container(
            child: Text('老孟，专注分享Flutter技术及应用'),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,//圆角矩形
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue),
          )
          ,
          Container(
            child: Text('老孟，专注分享Flutter技术及应用'),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all( //边框
                color: Colors.blue,
                width: 2,
              ),
            ),
          )
          ,
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image:  DecorationImage(
                image: NetworkImage(
                    'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),//圆角
            ),
          )
,
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              shape: BoxShape.circle, //形状
            ),
          )
          ,
          Container(
            color: Colors.blue,
            child: Text('老孟，一个有态度的程序员'),
            alignment: Alignment.center,
          )
          ,
          Container(
            color: Colors.blue,
            child: Text('老孟，专注分享Flutter技术及应用'),
            alignment: Alignment.center,
            height: 60, //设置宽高
            width: 250,
          )
          ,
          Container(
            color: Colors.blue,
            child: Text('老孟，专注分享Flutter技术及应用'),
            alignment: Alignment.center,
            constraints: BoxConstraints( //通过 constraints 属性设置最大/小宽、高来确定大小，如果不设置，默认最小宽高是0，最大宽高是无限大（double.infinity）
              maxHeight: 100,
              maxWidth: 300,
              minHeight: 100,
              minWidth: 100,
            ),
          ),
          Container(
            color: Colors.blue,
            child: Text('老孟，专注分享Flutter技术及应用'),
            alignment: Alignment.center,
            height: 60,
            width: 250,
            transform: Matrix4.rotationZ(0.5),//通过transform可以旋转、平移、缩放Container
          ),

          Container(
            height: 300,
            width: 300,
            color: Colors.blue,
            alignment: Alignment.center,
            child: AspectRatio( //设置宽高比
              aspectRatio: 2 / 1,
              child: Container(color: Colors.red,),
            ),
          ),

          Container(
            height: 200,
            width: 200,
            color: Colors.blue,
            child: FractionallySizedBox( //相对父控件
              widthFactor: .8,
              heightFactor: .3,
              child: Container(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
