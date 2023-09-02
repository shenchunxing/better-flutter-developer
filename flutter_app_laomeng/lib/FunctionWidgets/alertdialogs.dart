import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AlertDialogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RaisedButton(
            child: Text('AlertDialog'),
            onPressed: () async {
              var result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('提示'),
                      content: Text('确认删除吗？'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop('cancel'); //弹窗消失
                          },
                        ),
                        FlatButton(
                          child: Text('确认'),
                          onPressed: () {
                            Navigator.of(context).pop('ok');
                          },
                        ),
                      ],
                    );
                  });
              print('$result'); //选择的结果
            },
          ),

          RaisedButton(
            child: Text('CupertinoAlertDialog'),
            onPressed: () {
              showCupertinoDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('提示'),
                      content: Text('确认删除吗？'),
                      actions: <Widget>[
                        CupertinoDialogAction(child: Text('取消'),onPressed: (){
                          Navigator.of(context).pop('cancel');
                        },),
                        CupertinoDialogAction(child: Text('确认'),onPressed: (){
                          Navigator.of(context).pop('ok');
                        },),
                      ],
                    );
                  });
            },
          ),

          RaisedButton(
            child: Text('SimpleDialog'),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return SimpleDialog(
                  title: Text('提示'),
                  children: <Widget>[
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: Text('确认删除吗？'),
                    ),
                    Divider(height: 1,),
                    FlatButton(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop('cancel');
                      },
                    ),
                    Divider(height: 1,),
                    FlatButton(
                      child: Text('确认'),
                      onPressed: () {
                        Navigator.of(context).pop('ok');
                      },
                    ),
                  ],
                );
              });
            },
          ),

          RaisedButton(
            child: Text('Dialog'),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return Dialog(
                  child: Text('完全自定义弹窗'),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
