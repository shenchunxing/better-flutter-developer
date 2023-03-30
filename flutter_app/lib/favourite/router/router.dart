

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/pages/detail/detail.dart';
import 'package:flutter_app/favourite/pages/filter/filter.dart';
import 'package:flutter_app/favourite/pages/main_screen.dart';
import 'package:flutter_app/favourite/pages/meal/meal.dart';

class HYRouter {
  static final String initialRoute = HYMainScreen.routeName;

  //映射关系
  static final Map<String,WidgetBuilder> routes = {
    HYMainScreen.routeName : (ctx) => HYMainScreen(),//主页
  HYMealScreen.routeName : (ctx) => HYMealScreen(),//美食
  HYDetailScreen.routeName : (ctx) => HYDetailScreen(), //详情
    HYFilterScreen.routeName : (ctx) => HYFilterScreen(),//过滤
  };

//监听路由
  static final RouteFactory generateRoute = (settings) {
    if (settings.name == HYFilterScreen.routeName) {
      return MaterialPageRoute(builder: (ctx) {
        return HYFilterScreen();
      },fullscreenDialog: true);
    }
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return null;
  };
}