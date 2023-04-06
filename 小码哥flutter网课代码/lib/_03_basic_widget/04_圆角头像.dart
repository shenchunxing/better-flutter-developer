import 'package:flutter/material.dart';

void main() {
  runApp(Radiusheader());
}

class Radiusheader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CircleAcatarDemo(),
    );
  }
}


class CircleAcatarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar( //圆角
        radius:200, //半径200，直径400
        backgroundImage: NetworkImage('https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png'), //背景图片
        child: Container( //容器大小是200 * 200
          alignment: Alignment(1,1), //文字在容器中的显示位置
          width: 200,
          height: 200,
          child: Text('3333333'),
        ),
      ),
    );
  }
}

class ClipOvalDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval( //剪切
        child: Image.network(
          'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png',
          width: 200,
          height: 200,
          color: Colors.green,
        ),
      ),
    );
  }
}
