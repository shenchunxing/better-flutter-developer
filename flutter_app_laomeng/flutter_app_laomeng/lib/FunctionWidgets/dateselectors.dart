import 'package:flutter/material.dart';

class DateSelectors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RaisedButton(
              child: Text('弹出日期组件'),
              onPressed: () async {
               var result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2025),
//            initialEntryMode: DatePickerEntryMode.input,//直接显示 输入模式，默认是日历模式。
                  initialDatePickerMode: DatePickerMode.year,//设置日历日期选择器的初始显示，包含 day 和 year
                  //设置顶部标题、取消按钮、确定按钮 文案
                  helpText: '选择日期',
                  cancelText: '取消',
                  confirmText: '确定',

                 // 修改 输入模式 下文案
                  errorFormatText: '错误的日期格式',
                  errorInvalidText: '日期格式非法',
                  fieldHintText: '月/日/年',
                  fieldLabelText: '填写日期',

                  //设置可选日期范围:今天以后的日期都不可选
                  selectableDayPredicate: (date) {
                    return date.difference(DateTime.now()).inMilliseconds < 0;
                  },

                  //设置深色主题使 builder ，其用于包装对话框窗口小部件以添加继承的窗口小部件
                    builder: (context,child){
                      return Theme(
                        data: ThemeData.dark(),
                        child: child!,
                      );
                    },

                 //设置只支持中文
                   locale: Locale('zh'),
                );

               print('$result');
              }),


          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2025),
            onDateChanged: (d) {
              print('$d');
            },
          ),

          //范围日期
          RaisedButton(
            child: Text('范围日期'),
            onPressed: () async {
              var date = showDateRangePicker(context: context, firstDate: DateTime(2010), lastDate: DateTime(2025));
            },
          ),


        ],
      ),
    );
  }
}
