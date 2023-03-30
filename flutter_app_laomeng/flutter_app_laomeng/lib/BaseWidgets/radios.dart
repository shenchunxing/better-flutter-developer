import 'package:flutter/material.dart';

class Radios extends StatefulWidget {
  @override
  State<Radios> createState() => _RadiosState();
}

class _RadiosState extends State<Radios> {
  var _radioValue = '1';
  var _radioGroupValue = '';
  var _radioGroupValue2 = '语文';

  @override
  Widget build(BuildContext context) {
    return radioDemo3(context);
  }

  Widget radioDemo1(BuildContext context) {
    return Radio(
      value: _radioValue,
      groupValue: _radioGroupValue,
      onChanged: (value) {
        print('$value');
        setState(() {
          _radioGroupValue = value as String;
        });
      },
    );
  }

  //多个选项
  Widget radioDemo2(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: '语文',
          groupValue: _radioGroupValue,
          onChanged: (value){
            setState(() {
              _radioGroupValue = value as String;
            });
          },
        ),
        Radio(
          value: '数学',
          groupValue: _radioGroupValue,
          onChanged: (value){
            setState(() {
              _radioGroupValue = value as String;
            });
          },
        ),
        Radio(
          value: '英语',
          groupValue: _radioGroupValue,
          onChanged: (value){
            setState(() {
              _radioGroupValue = value as String;
            });
          },
        ),
      ],
    );
  }

  ///带文本的多选框RadioListTile
  Widget radioDemo3(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: RadioListTile(
            title: Text('语文'),
            value: '语文',
            groupValue: _radioGroupValue,
            onChanged: (value) {
              setState(() {
                _radioGroupValue = value as String;
              });
            },
          ),
        ),
        Flexible(
            child: RadioListTile(
              title: Text('数学'),
              value: '数学',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value as String;
                });
              },
            )),
        Flexible(
            child: RadioListTile(
              title: Text('英语'),
              value: '英语',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value as String;
                });
              },
            )),
      ],
    );
  }
}