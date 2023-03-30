import 'package:flutter/material.dart';

class ListViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollBarDemo();
  }

  //数据较少时
  Widget listView() {
    return ListView(
      children: <Widget>[
        _ListItem(title: '1',),
        _ListItem(title: '2',),
        _ListItem(title: '3',),
        _ListItem(title: '4',),
        _ListItem(title: '5',),
        _ListItem(title: '6',),
      ],
    );
  }

  //有大量数据时，使用动态创建列表的方式
  Widget builder() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      reverse: false,
      itemCount: 30,
      itemExtent: 50,
      itemBuilder: (BuildContext context, int index) {
        return _ListItem(
          title: '$index',
        );
      },
    );
  }

  //分割线
  Widget separated() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 45,
          alignment: Alignment.center,
          child: Text('$index'),
        );
      },
      separatorBuilder: (BuildContext context, int index){
        return Divider();
      },
      itemCount: 30,

    );
  }
}

class _ListItem extends StatelessWidget {

  final String title;

  const _ListItem({Key? key,required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 45,
        alignment: Alignment.center,
        child: Text('$title'),
      ),
    );
  }
}

//ScrollController监听滚动位置
class ScrollControllerDemo extends StatefulWidget {
  @override
  _ScrollControllerDemoState createState() => _ScrollControllerDemoState();
}

class _ScrollControllerDemoState extends State<ScrollControllerDemo> {
 late ScrollController _controller;
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        print('${_controller.position}');
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
            child: RaisedButton(
              child: Text('滚动到指定位置'),
              onPressed: () {
                _controller.animateTo(200,
                    duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
            ),
          ),
          Expanded( //因为上面的Container没有指定大小，这里需要设定尽量扩展
            child: Scrollbar( //滚动条
              child: ListView.builder(
//              physics: NeverScrollableScrollPhysics(), //物理特性：禁止滚动
                controller: _controller,
                reverse: false,
                itemBuilder: (BuildContext context, int index) {
                  return _ListItem(
                    title: '$index',
                  );
                },
                itemCount: 30,
                itemExtent: 50,
              ),
            ),
          ),
        ],
      );
  }
}

//自定义滚动条
class CustomScrollBarDemo extends StatefulWidget {
  @override
  _CustomScrollBarDemoState createState() => _CustomScrollBarDemoState();
}

class _CustomScrollBarDemoState extends State<CustomScrollBarDemo> {
  double _alignmentY = -1;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>( //监听滚动的位置
      onNotification: _handleScrollNotification,
      child: Stack(
        alignment: Alignment.topRight, //右侧位置
        children: [
          ListView.builder(
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: Text('$index'),
                ),
              );
            },
            itemCount: 30,
            itemExtent: 50,
          ),

          //滚动条
//          Container(
//            alignment: Alignment(1, _alignmentY),
//            padding: EdgeInsets.only(right: 5),
//            child: Container(
//              height: 100,
//              width: 20,
//              color: Colors.red,
//            ),
//          )
        Container(
          alignment: Alignment(1,_alignmentY),
          child: _ScrollBar(),
        )
        ],
      ),
    );
  }

  //滚动回调
  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('滚动组件最大滚动距离:${metrics.maxScrollExtent}');
    print('当前滚动位置:${metrics.pixels}');
    //计算偏移量
    setState(() {
      _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    });
    return true;
  }
}

//自定义的滚动条
class _ScrollBar extends StatefulWidget {
  @override
  State<_ScrollBar> createState() => _ScrollBarState();
}

class _ScrollBarState extends State<_ScrollBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.arrow_drop_up,
            size: 18,
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 18,
          ),
        ],
      ),
    );
  }
}



