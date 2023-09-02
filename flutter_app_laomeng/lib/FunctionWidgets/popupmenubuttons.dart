import 'package:flutter/material.dart';

class PopUpMenuButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
//      icon: Icon(Icons.add),
      initialValue: '数学',
      offset: Offset(0,100),//控制菜单弹出的位置，
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.red
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      onSelected: (value){
        print('$value');
      },
      onCanceled: (){
        print('onCanceled');
      },
      tooltip: '长按提示',
      elevation: 5,
      padding: EdgeInsets.all(5),
      color: Colors.black12,
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: '语文',
            textStyle: TextStyle(color: Colors.green),
            child: Text('语文'),
          ),
          PopupMenuDivider(height: 20,),//分割线
          PopupMenuItem<String>(
            value: '数学',
            child: Text('数学'),
          ),
          CheckedPopupMenuItem<String>(
            value: '英语',
            checked: true,
            child: Text('英语'),
          ),
          PopupMenuItem<String>(
            value: '生物',
            child: Text('生物'),
          ),
          PopupMenuItem<String>(
            value: '化学',
            child: Text('化学'),
          ),
        ];
      },
    );
  }
}
