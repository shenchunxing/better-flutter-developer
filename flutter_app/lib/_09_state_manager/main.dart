import 'package:flutter/material.dart';
import 'package:flutter_app/_09_state_manager/viewmodel/counter_viewmodel.dart';
import 'package:flutter_app/_09_state_manager/viewmodel/initialize_providers.dart';
import 'package:flutter_app/_09_state_manager/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //多个共享数据
    MultiProvider(providers: providers,child: MyApp(),),
  );

  //  runApp(
//    // 2.在应用程序的顶层ChangeNotifierProvider
//    ChangeNotifierProvider(
//      create: (ctx) => HYCounterViewModel(),
//      child: ChangeNotifierProvider(
//        create: (ctx) => HYUserViewModel(userInfo),
//        child: MyApp(),
//      ),
//    )
//  );
}

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
              HYShowData01(),
              HYShowData02(),
              HYShowData03(),
            ],
          ),
        ),
        floatingActionButton: Selector<HYCounterViewModel, HYCounterViewModel>(
          selector: (ctx, counterVM) => counterVM,
          shouldRebuild: (prev, next) => false,
          builder: (ctx, counterVM, child) {
            print("floatingActionButton build方法被执行");
            return FloatingActionButton(
              child: child,
              onPressed: () {
                counterVM.counter += 1;
              },
            );
          },
          child: Icon(Icons.add),
        )
    );
  }
}

class HYShowData01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3.在其它位置使用共享的数据
    int counter = Provider.of<HYCounterViewModel>(context).counter;

    print("data01的build方法");

    return Container(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Text("当前计数: $counter", style: TextStyle(fontSize: 30),),
        ],
      ),
    );
  }
}

class HYShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print("data02的build方法");

    return Container(
      color: Colors.red,
      child: Consumer<HYCounterViewModel>(
        builder: (ctx, counterVM, child) {
          print("data02 Consumer build方法被执行");
          return Text("当前计数: ${counterVM.counter}", style: TextStyle(fontSize: 30),);
        },
      ),
    );
  }
}

class HYShowData03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of Consumer Selector Consumer2
    //拿到多个模型进行操作
    return Consumer2<HYUserViewModel, HYCounterViewModel>(
      //4个参数：上下文、共享数据1、共享数据2、child
      builder: (ctx, userVM, counterVM, child) {
        return Text(
          "nickname:${userVM.userInfo.nickname} counter:${counterVM.counter}",
          style: TextStyle(fontSize: 24),
        );
      },
    );
  }
}