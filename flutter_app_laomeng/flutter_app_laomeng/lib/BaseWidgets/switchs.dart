import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Switchs extends StatefulWidget {
  @override
  _SwitchsState createState() => _SwitchsState();
}

class _SwitchsState extends State<Switchs> {
  var _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return switchsDemo2();
  }

  Widget switchsDemo1() {
    return Switch(
      activeColor: Colors.red,
      activeTrackColor: Colors.blue,


      inactiveThumbColor: Colors.black54,
      inactiveTrackColor: Colors.yellow,

      //设置图片
      //inactiveThumbImage: AssetImage('images/bird.png',),

      value: _switchValue,
      onChanged: (value){
        setState(() {
          _switchValue = value;
        });
      },
    );
  }

  //SwitchListTile
  Widget switchsDemo2() {
    return SwitchListTile(
      title:Text('是否允许4G下载'),
      value: _switchValue,
      onChanged: (value){
        setState(() {
          _switchValue = value;
        });
      },
    );
  }

  Widget switchsDemo3() {
    return CupertinoSwitch(
      value: _switchValue,
      onChanged: (value){
        setState(() {
          _switchValue = value;
        });
      },
    );
  }
}
