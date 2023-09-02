import 'package:flutter/material.dart';

void main() {
  runApp(ExtensionDemo());
}

class ExtensionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ButtonExtensionDemo(),
    );
  }
}

class ButtonExtensionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1.默认情况下Button上下有一定的间距
    // 2.Button变小: ButtonTheme
    // 3.取出Button的内边距
    return Column(
      children: [
        SizedBox(height: 150,),
        ButtonTheme( //定制button宽高
          minWidth: 60,
          height: 50,
          child: FlatButton(
            padding: EdgeInsets.all(5),
            color: Colors.red,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text('Flat Button'),
            textColor: Colors.white,
            onPressed: () {

            },
          ),
        ),
      ],
    );
  }
}

///带占位图的image
class ImageExtensionDemo extends StatelessWidget {
  final String imageURL;
  ImageExtensionDemo(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: AssetImage('assets/images/juren.jpeg'),
        image: NetworkImage(imageURL),
        fadeInDuration: Duration(milliseconds: 1), //渐入动画
        fadeOutDuration: Duration(milliseconds: 1),//渐出动画
    );
  }
}

class IconExtensionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Icon字体图标和图片图标
    // 1.字体图标矢量图(放大的时候不会失真)
    // 2.字体图标可以设置颜色
    // 3.图标很多时, 占据空间更小
//    return Icon(Icons.pets, size: 300, color: Colors.orange,);
//    return Icon(IconData(0xe91d, fontFamily: 'MaterialIcons'), size: 300, color: Colors.orange,);
    // 1.0xe91d -> unicode编码
    // 2.设置对应的字体
    return Text('\ue91d',style: TextStyle(fontSize: 100,color: Colors.orange,fontFamily: 'MaterialIcons'),);
  }
}
