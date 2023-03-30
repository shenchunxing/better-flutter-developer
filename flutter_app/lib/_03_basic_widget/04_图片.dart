import 'package:flutter/material.dart';

void main() {
  runApp(ImageApp());
}

class ImageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageDemo01("https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png"),
    );
  }
}

class ImageDemo02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/juren.jpeg');
  }
}

class ImageDemo01 extends StatelessWidget {
  final String imageURL;

  ImageDemo01(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Image(
      color: Colors.red,//混合色值
      colorBlendMode: BlendMode.colorDodge,//混合模式
      image: NetworkImage(imageURL),
      width: 200,
      height: 200,
      fit: BoxFit.cover,//缩放模式
      repeat: ImageRepeat.repeatY, //重复模式
      alignment: Alignment(-1,1),
    );
  }
}

class ImageDemo03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( //居中
      child: Container( //容器
        width: 300,
        height: 300,
        color: Colors.yellow,
        child: Image.asset('assets/images/juren.jpeg'), //图片适应容器
      ),
    );
  }
}

