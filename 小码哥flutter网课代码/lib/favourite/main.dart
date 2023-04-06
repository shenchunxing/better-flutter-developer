import 'package:flutter/material.dart';
import 'package:flutter_app/_14_screenfit/size_fit.dart';
import 'package:flutter_app/favourite/pages/share/app_theme.dart';
import 'package:flutter_app/favourite/viewmodel/favor_view_model.dart';
import 'package:flutter_app/favourite/viewmodel/filter_view_model.dart';
import 'package:provider/provider.dart';
import 'viewmodel/meal_view_model.dart';
import 'router/router.dart';

void main() {
  runApp(
    //多个数据共享
      MultiProvider(
        providers: [
          //HYFilterViewModel：筛选条件
          ChangeNotifierProvider(create: (ctx) => HYFilterViewModel(),),
          //HYMealViewModel依赖HYFilterViewModel，所以需要ChangeNotifierProxyProvider，可以串2个参数
          ChangeNotifierProxyProvider<HYFilterViewModel,HYMealViewModel>( //过滤后，meal页面的数据也会被过滤隐藏掉
            create: (ctx) => HYMealViewModel(),
            update: (ctx , filterVM ,mealVM) {
              mealVM?.updateFilters(filterVM);
              return mealVM!;
            },
          ),
          //HYFavorViewModel依赖HYFilterViewModel，所以需要ChangeNotifierProxyProvider，可以串2个参数
          ChangeNotifierProxyProvider<HYFilterViewModel,HYFavorViewModel>(//过滤后，收藏页面的数据也会被过滤隐藏掉
            create: (ctx) => HYFavorViewModel(),
            update: (ctx, filterVM,favorVM) {
              favorVM?.updateFilters(filterVM);
              return favorVM!;
            },
          ),
        ],
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 对HYSizeFit进行初始化
    HYSizeFit.initialize();

    return MaterialApp(
      theme: HYAppTheme.norTheme,
      initialRoute: HYRouter.initialRoute,
      routes: HYRouter.routes,
      onGenerateRoute: HYRouter.generateRoute,
      onUnknownRoute: HYRouter.unknownRoute,
    );
  }
}
