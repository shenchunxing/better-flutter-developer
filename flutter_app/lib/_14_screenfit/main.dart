import 'package:flutter/material.dart';
import 'package:flutter_app/_14_screenfit/size_fit.dart';
import 'double_extension.dart';
import 'int_extension.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(); //初始化，为了可以获取到屏幕的数据，因为window可能还没创建，如果获取屏幕数据的话，导致获取到的数据为null

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

    // 2.手机屏幕的大小(逻辑分辨率)，利用MediaQuery获取
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final statusHeight = MediaQuery.of(context).padding.top;
    print("屏幕宽高: $width * $height");
    print("状态栏的高度: $statusHeight");

    print(HYSizeFit.screenWidth);//利用window获取
    print(HYSizeFit.screenHeight);
    print(HYSizeFit.statusHeight);

    print(200.px);
    print(245.89.px);

    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: Container(
          width: 200.px,
          height: 233.00.px,
          color: Colors.red,
          alignment: Alignment.center,
          child: Text("Hello World", style: TextStyle(fontSize: 20.px),),
        ),
      ),
    );
  }
}
