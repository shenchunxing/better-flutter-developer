import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatefulWidget {
  @override
  _TextDemoState createState() => _TextDemoState();
}

class _TextDemoState extends State<TextDemo> {
  @override
  Widget build(BuildContext context) {
    return richTextDemo2(context);
  }
}
//富文本
Widget richTextDemo(BuildContext context) {
  return RichText(
    text: TextSpan(
        style: DefaultTextStyle.of(context).style, //默认字体样式
        children: <InlineSpan>[ //带下划线的
          TextSpan(text: '老孟',style: TextStyle(color: Colors.green)),
          TextSpan(text: '，'),
          TextSpan(text: '一个有态度的程序员'),
        ]),
  );
}

//手势交互
Widget richTextDemo2(BuildContext context) {
  return RichText(
    text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <InlineSpan>[
          TextSpan(text: '登陆即视为同意'),
          TextSpan(
            text: '《xxx服务协议》',
            style: TextStyle(color: Colors.red),
            recognizer: TapGestureRecognizer()..onTap = () {
              print("onTap click");
            },
          ),
        ]),
  );
}