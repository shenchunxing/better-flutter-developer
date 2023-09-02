import 'package:flutter/material.dart';

class GridViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return singleChildScrollView();
  }

  Widget gridViewsDemo1() {
    return GridView(
      scrollDirection: Axis.horizontal, //滚动方向
      reverse: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
          crossAxisSpacing: 2, //交叉轴间距
          mainAxisSpacing: 4 //主轴间距
      ),
      children: [
        _createGridViewItem(Colors.primaries[0]),
        _createGridViewItem(Colors.primaries[1]),
        _createGridViewItem(Colors.primaries[2]),
        _createGridViewItem(Colors.primaries[3]),
        _createGridViewItem(Colors.primaries[4]),
        _createGridViewItem(Colors.primaries[5]),
        _createGridViewItem(Colors.primaries[6]),
        _createGridViewItem(Colors.primaries[7]),

      ],
    );
  }

  _createGridViewItem(Color color){
    return Container(
      height: 80,
      color: color,
    );
  }

  //builder
  Widget gridViewsDemo2() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          color: Colors.primaries[index % Colors.primaries.length],
        );
      },
      itemCount: 50,
    );
  }

  //custom
  Widget gridViewsDemo3() {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      childrenDelegate: SliverChildBuilderDelegate((context, index) {
        return Container(
            height: 80,
            color: Colors.primaries[index % Colors.primaries.length]);
      }, childCount: 50),
    );
  }

  //count
    Widget gridViewsDemo4() {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(50, (i) {
          return Container(
            height: 80,
            color: Colors.primaries[i % Colors.primaries.length],
          );
        }),
      );
    }

    //extent
  Widget gridViewsDemo5() {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      children: List.generate(50, (i) {
        return Container(
          height: 80,
          color: Colors.primaries[i % Colors.primaries.length],
        );
      }),
    );
  }

  //简单滚动
  Widget singleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(50, (index) {
          return Container(
            height: 150,
            color: Colors.primaries[index % Colors.primaries.length],
          );
        }).toList(),
      ),
    );

  }
}
