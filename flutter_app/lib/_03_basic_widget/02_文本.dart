import 'package:flutter/material.dart';

void main() {
  runApp(TextApp());
}

class TextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextDemo(),
    );
  }
}

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "《定风波》 苏轼 莫听穿林打叶声，何妨吟啸且徐行。竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。",
      textAlign: TextAlign.left,//对齐
      maxLines: 3,//多行显示
      overflow: TextOverflow.ellipsis,//超过范围
      textScaleFactor: 1.5,//缩放系数
      style: TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.bold,//字重
      ),
    );
  }
}

class TextRichDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      child: Text.rich( //富文本
        TextSpan(
          text: 'hello world',
          style: TextStyle(color: Colors.red,fontSize: 50),
          children: [
            TextSpan(text: 'hello world',style: TextStyle(color: Colors.red,fontSize: 25)),//单独设置
            TextSpan(text: 'hello flutter',style: TextStyle(color: Colors.green)),
            WidgetSpan(child: Icon(Icons.favorite,color: Colors.red,)),//设置带颜色的icon
            TextSpan(text: 'hello dart',style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
