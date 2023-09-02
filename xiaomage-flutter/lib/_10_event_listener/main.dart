import 'package:flutter/material.dart';
import '02_eventbus.dart';

class UserInfo {
  String nickname;
  int level;

  UserInfo(this.nickname,this.level);
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表测试"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HYButton(),
            HYText()
          ],
        ),
      ),
    );
  }
}


class HYButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: () {
      final info = UserInfo('codewhy', 22);
      eventBus.fire(info); //发出事件
    },child: Text('按钮'),);
  }
}

class HYText extends StatefulWidget {
  @override
  _HYTextState createState() => _HYTextState();
}

class _HYTextState extends State<HYText> {
  String message = 'hello world';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //拿到事件总线
    eventBus.on<UserInfo>().listen((userInfo) {
      print('监听到数据：${userInfo.nickname}');
      print('监听到数据：${userInfo.level}');
      setState(() {
        message = '${userInfo.nickname} - ${userInfo.level}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(message,style: TextStyle(fontSize: 20),);
  }
}
