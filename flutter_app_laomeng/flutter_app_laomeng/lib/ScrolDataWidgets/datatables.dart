import 'package:flutter/material.dart';

class User {
  User(this.name, this.age,{this.selected = false});

  final String name;
  final int age;
  bool selected;
}

class DataTables extends StatefulWidget {
  @override
  _DataTablesState createState() => _DataTablesState();
}

class _DataTablesState extends State<DataTables> {

  //数据
  List<User> data = [
    User('老孟', 18),
    User('老孟1', 19,selected: true),
    User('老孟2', 20),
    User('老孟3', 21),
    User('老孟4', 22),
  ];

  var _sortAscending = true; //升序

  @override
  Widget build(BuildContext context) {
    List<DataRow> dateRows = []; //重载的时候，置空
    //赋值
    for (int i = 0; i < data.length; i++) {
      dateRows.add(DataRow(
        selected: data[i].selected,
        onSelectChanged: (selected){
          setState(() {
            data[i].selected = selected as bool;
          });
        },
        cells: [
          //placeholder文字变灰，showEditIcon编辑图片
          DataCell(Text('${data[i].name}'),placeholder: true,showEditIcon: true,onTap: () {
            print("DataCell onTap");
          }),
          DataCell(Text('${data[i].age}')),
          DataCell(Text('男')),
          DataCell(Text('2020')),
          DataCell(Text('10')),
        ],
      ));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          sortColumnIndex: 1,
          sortAscending: _sortAscending,
          columns: [
        DataColumn(label: Text('姓名'), tooltip: '长按提示'),
        DataColumn(
          label: Text('年龄'),
          //排序
          onSort: (int columnIndex, bool ascending) { //年龄排序
            setState(() {
              _sortAscending = ascending;
              if(ascending){
                data.sort((a, b) => a.age.compareTo(b.age));
              }else {
                data.sort((a, b) => b.age.compareTo(a.age));
              }
            });
          }
        ),
        DataColumn(
          label: Text('性别'),
        ),
        DataColumn(
          label: Text('出生年份'),
        ),
        DataColumn(
          label: Text('出生月份'),
        ),
      ], rows: dateRows),
    );
  }
}
