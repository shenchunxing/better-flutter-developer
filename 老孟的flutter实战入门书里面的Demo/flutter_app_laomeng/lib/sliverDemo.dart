import 'package:flutter/material.dart';

class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return sliverAppBarDemo();
  }
}

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

Widget sliverAppBarDemo() {
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
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