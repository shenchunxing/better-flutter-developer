import 'package:flutter/material.dart';
import 'detail.dart';
import 'about.dart';
import 'main.dart';
import 'unknown.dart';

class HYRouter {
  //路由数组
  static final Map<String , WidgetBuilder> routes = {
    HYHomePage.routeName : (ctx) => HYHomePage(),
    HYAboutPage.routeName : (ctx) => HYAboutPage()
  };

  //默认路由
  static final String initialRoute = HYHomePage.routeName;

  //监听路由
  static final RouteFactory generateRoute = (settings) {
    if (settings.name == HYDetailPage.routerName) {
      return MaterialPageRoute( //跳转到详情
          builder: (ctx) {
            return HYDetailPage(settings.arguments as String);
          }
      );
    }

    return null;
  } ;

  //未知路由
  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(
      builder: (ctx) {
        return HYUnknownPage();
      }
    );
  };
}