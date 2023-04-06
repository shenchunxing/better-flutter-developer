import 'package:flutter/material.dart';

void main() {
  runApp(ButtonApp());
}

class ButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ButtonDemo(),
    );
  }
}

class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100,),
        //水波纹
        RaisedButton(child: Text('RaisedButton'),textColor: Colors.white,color: Colors.purple,onPressed: () {
          print("RaisedButton Click");
        }),

        //扁平
        FlatButton(onPressed: (){
          print("FlatButton Click");
        }, child: Text('FlatButton'),color: Colors.orange,),

        //悬浮
        FloatingActionButton(onPressed: () {
          print('FloatingActionButton click');
        },child: Text('FloatingActionButton')),

        OutlinedButton(onPressed: () {
          print('OutlinedButton click');
        }, child: Text('OutlinedButton')),

        FlatButton(
          color: Colors.amberAccent,
          shape: RoundedRectangleBorder( //圆角
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,//最小尺寸
            children: [
              Icon(Icons.favorite,color: Colors.red,),
              SizedBox(width: 10,),//间距
              Text('喜欢作者'),
            ],
          ),
          onPressed: () {

          },
        ),


        //自定义按钮
        RaisedButton(
          child: Text('同意协议',style: TextStyle(color: Colors.white),),
          color: Colors.orange, //按钮颜色
          highlightColor: Colors.orange[700],//高亮颜色
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),//圆角
          onPressed: () {

          },
        )
      ],
    );
  }
}
