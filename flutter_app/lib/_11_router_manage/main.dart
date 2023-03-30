import 'package:flutter/material.dart';
import 'package:flutter_app/_11_router_manage/about.dart';
import 'package:flutter_app/_11_router_manage/detail.dart';
import 'router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(primaryColor: Colors.blue,splashColor: Colors.transparent),
      routes: HYRouter.routes,//路由数组统一管理
      onGenerateRoute: HYRouter.generateRoute,//监听路由
      initialRoute: HYRouter.initialRoute,//初始化路由
      onUnknownRoute: HYRouter.unknownRoute,//未知路由
    );
  }
}

class HYHomePage extends StatefulWidget {
  static const String routeName = '/';
  @override
  State<HYHomePage> createState() => _HYHomePageState();
}

class _HYHomePageState extends State<HYHomePage> {
  String _homeMessage = 'default message';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_homeMessage,style: TextStyle(fontSize: 20),),
            RaisedButton(onPressed: () => jumpToDetail(context),child: Text('跳转到详情'),),
            RaisedButton(onPressed: () => jumpToAbout(context),child: Text('跳转到关于'),),
            RaisedButton(onPressed: () => jumpToDetail2(context),child: Text('第二种方式跳转到详情'),),
            RaisedButton(onPressed: () => jumpToSetting(context),child: Text('跳转到设置'),),
          ],
        ),
      ),
    );
  }

  void jumpToDetail(BuildContext context) {
    // 1.普通的跳转方式
    // 传递参数: 通过构造器直接传递即可
    Future future = Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return HYDetailPage('a home message');
    }));

    future.then((value) {
      setState(() {
        _homeMessage = value;
      });
    });
  }

  void jumpToAbout(BuildContext context) {
    Navigator.of(context).pushNamed(HYAboutPage.routeName,arguments: 'a about message');
  }

  void jumpToDetail2(BuildContext context) {
    Navigator.of(context).pushNamed(HYDetailPage.routerName,arguments: 'a detail2 message');
  }

  void jumpToSetting(BuildContext context) {
    Navigator.of(context).pushNamed('/unknown');
  }
}


