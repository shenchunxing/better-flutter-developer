import 'package:flutter_app/_09_state_manager/model/user_info.dart';
import 'package:flutter_app/_09_state_manager/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'counter_viewmodel.dart';

//多个数据共享
List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (ctx) => HYCounterViewModel()),
  ChangeNotifierProvider(create: (ctx) => HYUserViewModel(UserInfo("why", 29, "abc")),),
];