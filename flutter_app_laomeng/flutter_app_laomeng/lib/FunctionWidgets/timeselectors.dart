import 'package:flutter/material.dart';

//和日期选择器基本一样
class TimeSelectors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RaisedButton(
            child: Text('弹出时间选择器'),
            onPressed: () async {
              var result = showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                //设置 24小时 制
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
