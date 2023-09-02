
import 'package:flutter/material.dart';
import 'package:flutter_app/_14_screenfit/int_extension.dart';
import 'package:flutter_app/favourite/pages/filter/filter.dart';

class HYHomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.px,
      child: Drawer(
        child: Column(
          children: [
            buildHeaderView(context),
            buildListTile(context, Icon(Icons.restaurant), '进餐', () {
              Navigator.of(context).pop();
            }),
            buildListTile(context, Icon(Icons.settings), '过滤', () {
              Navigator.of(context).pushNamed(HYFilterScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.px,
      color: Colors.orange,
      margin: EdgeInsets.only(bottom: 20.px),
      alignment: Alignment(0,0.5),
      child: Text('开始动手',style: Theme.of(context).textTheme.headline4,),
    );
  }

  Widget buildListTile(BuildContext context , Widget icon , String title,void Function() handler) {
    return ListTile(
      leading: icon,
      title: Text(title,style: Theme.of(context).textTheme.headline2,),
      onTap: handler,
    );
  }
}
