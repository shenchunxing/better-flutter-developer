import 'package:flutter/material.dart';

//联动
class StickyTabBar extends StatefulWidget {
  @override
  State<StickyTabBar> createState() => _StickyTabBarState();
}

class _StickyTabBarState extends State<StickyTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _newsKey = '资讯';
  final String _technologyKey = '科技';
  List<String> _newsList = [
    '1','2'
  ];
  List<String> _technologyList = [
    '3','4'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 230.0,
            pinned: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: PageView(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black, //颜色
                controller: this._tabController,
                tabs: <Widget>[ //项
                  Tab(text: '资讯'),
                  Tab(text: '技术'),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[
          RefreshIndicator(
            onRefresh: () async => print('onRefresh'),
            child: _buildTabNewsList(_newsKey, _newsList),
          ),

          _buildTabNewsList(_technologyKey, _technologyList),
        ],
      ),
    );
  }
  
  Widget _buildTabNewsList(String key , List<String> list) {
    return ListView.builder(itemBuilder: (context,index) {
      return Text(list[index],style: TextStyle(fontSize: 20),);
    },itemCount: list.length,itemExtent: 50,);
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


