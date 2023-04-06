import 'package:flutter/material.dart';

class HYDetailPage extends StatelessWidget {
  static const String routerName = '/detail';

  final String message;
  HYDetailPage(this.message);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 当返回为true时,可以自动返回(flutter帮助我们执行返回操作)
      // 当返回为false时, 自行写返回代码
      onWillPop: () {
        backToHome(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('详情页面'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message,style: TextStyle(fontSize: 20),),
              RaisedButton(onPressed: () => backToHome(context),child: Text('返回首页 '),)
            ],
          ),
        ),
      ),
    );
  }

  void backToHome(BuildContext context) {
    Navigator.of(context).pop('a detail message');
  }
}

