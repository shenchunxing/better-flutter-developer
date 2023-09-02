import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextWidgets extends StatefulWidget {
  @override
  _TextWidgetsState createState() => _TextWidgetsState();
}

class _TextWidgetsState extends State<TextWidgets> {
  @override
  Widget build(BuildContext context) {
    return TextWidgetsDemo4();
  }

  //过渡颜色位文字
   Widget TextWidgetsDemo1() {
     return Builder( //Builder组件是为了计算当前Text组件大小，生成LinearGradient。
       builder: (BuildContext context) {
         RenderBox? box = context.findRenderObject() as RenderBox;
         final Shader linearGradient = LinearGradient( //线性渐变
           colors: <Color>[Colors.purple, Colors.blue],
         ).createShader(
             Rect.fromLTWH(0.0, 0.0, box.size.width, box.size.height));

         return Text(
           '老孟，专注分享Flutter技术和应用实战',
           style: new TextStyle(
               fontSize: 18.0,
               fontWeight: FontWeight.bold,
               foreground: Paint()..shader = linearGradient),
         );
       },
     );
   }

   //带前后置标签的文本
  Widget TextWidgetsDemo2() {
   return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            WidgetSpan(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, //矩形
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.blue),
                  child: Text(
                    '判断题',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            TextSpan(text: '泡沫灭火器可用于带电灭火'),

          ]),
    );
  }

  //服务协议
  Widget TextWidgetsDemo3() {
    return Text.rich(
      TextSpan(
          text: '登录即代表同意并阅读',
          style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
          children: [
            TextSpan(
              text: '《服务协议》',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('onTap');
                },
            ),
          ]),
    );
  }

  //登录密码输入框
  Widget TextWidgetsDemo4() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Color(0x30cccccc),
        filled: true,
        enabledBorder: OutlineInputBorder(//设置可用状态输入框的边框线颜色、边角弧度等,该属性值与border属性相同
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(200))),
        hintText: '输入密码',
        focusedBorder: OutlineInputBorder(//设置获得焦点时输入框的边框线的颜色、边角弧度等，使用方法与enabledBorder属性相同
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(200))),

      ),
      textAlign: TextAlign.center,
      obscureText: true,
      onChanged: (value) {

      },
    );
  }

  //评论回复
  Widget TextWidgetsDemo5() {
    return Text.rich(
      TextSpan(
          text: '回复',
          style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
          children: [
            TextSpan(
              text: '@老孟：',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('onTap');
                },
            ),
            TextSpan(
              text: '你好，想知道Flutter发展前景如何？',
            ),
          ]),
    );
  }
}
