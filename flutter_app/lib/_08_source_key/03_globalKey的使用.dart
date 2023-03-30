import 'package:flutter/material.dart';

class HYHomePage extends StatelessWidget {
  //GlobalKey可以帮助我们访问某个Widget的信息，包括Widget或State或Element等对象
  final GlobalKey<_HYHomeContentState> homeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('列表测试'),),
      body: HYHomeContent(key:homeKey),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.data_usage),
        onPressed: () {
          print("${homeKey.currentState?.value}"); //abc
          print('${homeKey.currentState?.widget.name}');//123
          print('${homeKey.currentContext}');
        },
      ),
    );
  }
}

class HYHomeContent extends StatefulWidget {
  final String name = '123';
  HYHomeContent({Key? key}) : super(key: key);

  @override
  _HYHomeContentState createState() => _HYHomeContentState();
}

class _HYHomeContentState extends State<HYHomeContent> {
  final String value = 'abc';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
