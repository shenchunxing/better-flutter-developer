import 'package:flutter/material.dart';

class CheckBoxs extends StatefulWidget {
  @override
  _CheckBoxsState createState() => _CheckBoxsState();
}

class _CheckBoxsState extends State<CheckBoxs> {
  var _checkValue = false;

  @override
  Widget build(BuildContext context) {
    return checkBoxsDemo2(context);
  }

  Widget checkBoxsDemo1(BuildContext context) {
    return Checkbox(
      value: _checkValue,
      activeColor: Colors.red,//选中背景
      checkColor: Colors.blue, //打钩颜色
      onChanged: (value){
        setState(() {
          _checkValue = value!;
        });
      },
    );
  }

  //CheckboxListTile
  Widget checkBoxsDemo2(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading, //选框位置
      subtitle: Text('一枚有态度的程序员'),
      secondary: Icon(Icons.person),
      title: Text('老孟'),
      value: _checkValue,
      onChanged: (value){
        setState(() {
          _checkValue = value!;
        });
      },
    );
  }
}
