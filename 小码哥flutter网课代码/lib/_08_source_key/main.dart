import 'package:flutter/material.dart';
import 'list_item_ful.dart';
import 'list_item_less.dart';
import '03_globalKey的使用.dart';

/**
 * key的使用
 */
void main() {
  runApp(MaterialApp(
//    home: HYHomePageState(),
  home: HYHomePage(),
  ));
}

class HYHomePageState extends StatefulWidget {
  @override
  _HYHomePageStateState createState() => _HYHomePageStateState();
}

class _HYHomePageStateState extends State<HYHomePageState> {
  List<String> names = ['aaa','bbb','ccc'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test key'),),
      body: ListView(
        children: names.map((e) {
          return ListItemFul(e,ValueKey(e));
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            names.removeAt(0);
          });
        },
      ),
    );
  }
}
