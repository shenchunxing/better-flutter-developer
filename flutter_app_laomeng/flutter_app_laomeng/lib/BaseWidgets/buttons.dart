import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonsDemo1();
  }

  Widget ButtonsDemo1() {
    return Column(
      children: [
        RaisedButton(
          child: Text('RaisedButton'),
          onPressed: () {
            print('onPressed');
          },
          onLongPress: () {
            print('onLongPress');
          },
          onHighlightChanged: (highlight) {
            print('onHighlightChanged:$highlight');
          },
          elevation: 10.0, //阴影
          shape: BeveledRectangleBorder( //按钮形状：矩形
              side: BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
        ),
        FlatButton(child: Text('FlatButton'),color: Colors.blue,onPressed: (){},),
        OutlinedButton(child: Text('OutlineButton'),onPressed: (){},),
      ],
    );
  }
}
