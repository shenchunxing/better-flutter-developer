import 'package:flutter/material.dart';
class SizeBoxs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          width: 200,
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text('老孟，专注分享Flutter技术及应用'),
          ),
        ),
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text('老孟，专注分享Flutter技术及应用'),
          ),
        ),
      ],
    );
  }
}
