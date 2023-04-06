import 'package:flutter/material.dart';

class Slivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return nestedScrollViewDemo();
  }

  //sliverList、sliverGrid
  Widget sliverListGridDemo() {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate((content, index) {
          return Container(
            height: 65,
            color: Colors.primaries[index % Colors.primaries.length],
          );
        }, childCount: 5),
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
          );
        }, childCount: 20),
      )
    ]);
  }

  //sliverAppBar:SliverAppBar控件可以实现页面头部区域展开、折叠的效果，类似于Android中的CollapsingToolbarLayout
  Widget sliverAppBarDemo() {
    return CustomScrollView( //SliverAppBar控件需要和CustomScrollView搭配使用,SliverAppBar要通常放在slivers的第一位，后面接其他sliver控件
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,//悬停
          expandedHeight: 200.0, //高度
          flexibleSpace: FlexibleSpaceBar( //flexibleSpace是SliverAppBar中展开和折叠区域，flexibleSpace与expandedHeight一起使用， expandedHeight表示flexibleSpace的高度，
            title: Text('复仇者联盟'),
            background: Image.network(
              'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Card(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.primaries[(index % 18)],
                  child: Text(''),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //SliverPersistentHeader控件当滚动到边缘时根据滚动的距离缩小高度，有点类似 SliverAppBar 的背景效果。
  Widget sliverPersistentHeaderDemo() {
    return CustomScrollView(
      slivers: <Widget>[
        //floating 设置为true时，向下滑动时，即使当前CustomScrollView不在顶部，SliverAppBar也会跟着一起向下出现
        //pinned 设置为true时，当SliverAppBar内容滑出屏幕时，将始终渲染一个固定在顶部的收起状态
        SliverPersistentHeader(
//          floating: true,
//          pinned: true, //悬停在头部
          delegate: MySliverPersistentHeaderDelegate(),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3),
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }, childCount: 20),
        )
      ],
    );
  }

  //liverToBoxAdapter：在使用CustomScrollView创建自定义滚动效果的时候，CustomScrollView只能包含sliver系列组件，如果包含普通的组件如何处理？使用SliverToBoxAdapter包裹
  Widget sliverToBoxAdapterDemo() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            color: Colors.black,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Container(
              height: 65,
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }, childCount: 50),
        )
      ],
    );
  }

  //多个滚动视图
  Widget customScrollViewDemo() {
   return CustomScrollView(
//     scrollDirection: Axis.horizontal, //滚动方向
//     reverse: false,//是否反向滚动
//   primary: true, //primary设置为true时，不能设置controller，因为primarytrue时，controller使用PrimaryScrollController，这种机制带来的好处是父组件可以控制子树中可滚动组件的滚动行为，例如，Scaffold正是使用这种机制在iOS中实现了点击导航栏回到顶部的功能。
//   controller: , //设置control监听滚动位置
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 230.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('复仇者联盟'),
            background: Image.network(
              'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SliverGrid.count(crossAxisCount: 4,children: List.generate(10, (index){
          return Container(
            color: Colors.primaries[index%Colors.primaries.length],
            alignment: Alignment.center,
            child: Text('$index',style: TextStyle(color: Colors.white,fontSize: 20),),
          );
        }).toList(),),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Container(
              height: 85,
              alignment: Alignment.center,
              color: Colors.primaries[index % Colors.primaries.length],
              child: Text('$index',style: TextStyle(color: Colors.white,fontSize: 20),),
            );
          }, childCount: 25),
        )
      ],
    );
  }

  //NestedScrollView 可以在其内部嵌套其他滚动视图的滚动视图，其滚动位置是固有链接的
  Widget nestedScrollViewDemo() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//        return <Widget>[SliverAppBar(
//          title: Text('老孟'),
//        )];
      //展开/折叠
      return <Widget>[SliverAppBar(
        expandedHeight: 230.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('复仇者联盟'),
          background: Image.network(
            'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
      )];
      },
      body: ListView.builder(itemBuilder: (BuildContext context,int index){
        return Container(
          height: 80,
          color: Colors.primaries[index % Colors.primaries.length],
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      },itemCount: 20,),
    );
  }
}

//SliverPersistentHeader的delegate需要我们自定义，build返回显示的内容，maxExtent和minExtent表示最大和最小值，滚动的时候高度在这个范围内变化
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text('我是一个SliverPersistentHeader',
            style: TextStyle(color: Colors.white)));
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 如果内容需要更新，设置为true
}

