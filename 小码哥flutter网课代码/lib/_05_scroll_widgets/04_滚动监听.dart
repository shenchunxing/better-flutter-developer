import 'package:flutter/material.dart';

void main() {
  runApp(CustomScrollViewListenApp());
}

class CustomScrollViewListenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatefulWidget {
  @override
  _HYHomePageState createState() => _HYHomePageState();
}

class _HYHomePageState extends State<HYHomePage> {
  ScrollController _controller = ScrollController(initialScrollOffset: 300); //初始偏移
  bool _isShowFloatingBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //监听滚动
    _controller.addListener(() {
      print("监听到滚动....: ${_controller.offset}");
      setState(() {
        _isShowFloatingBtn = _controller.offset > 1000;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 两种方式可以监听:
     *  controller:
     *    1.可以设置默认值offset
     *    2.监听滚动, 也可以监听滚动的位置
     *  NotificationListener
     *    1.开始滚动和结束滚动
     */
    return Scaffold(
       appBar: AppBar(
         title: Text('列表测试'),
       ),
      body: (
         NotificationListener(
           onNotification: (ScrollNotification notification) {
             if (notification is ScrollStartNotification) { //开始滚动
               print ('开始滚动');
             } else if (notification is ScrollUpdateNotification) { //正在滚动
                print ('正在滚动...,总滚动距离:${notification.metrics.maxScrollExtent}  当前滚动的位置:${notification.metrics.pixels}');
             } else if (notification is ScrollEndNotification){
               print ('结束滚动');
             }

             return true;
           },

           child: ListView.builder(
              controller: _controller,
             itemCount: 100,
             itemBuilder: (BuildContext ctx , int index) {
                return ListTile(title: Text("联系人:$index"),leading: Icon(Icons.people),);
             },
           ),
         )
      ),

      //是否展示悬浮按钮的逻辑
      floatingActionButton: _isShowFloatingBtn ? FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () { //滚动到顶部
          _controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeIn);
        },
      ) : null,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
