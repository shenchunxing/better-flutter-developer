import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/category_model.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/favourite/pages/widges/meal_item.dart';
import 'package:flutter_app/favourite/viewmodel/meal_view_model.dart';
import 'package:provider/provider.dart';

class HYMealContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as HYCategoryModel;

    //selector参数可以对数据进行改造，这里是过滤操作
    return Selector<HYMealViewModel,List<HYMealModel>>(
      selector: (ctx,mealVM) {
        return mealVM.meals.where((element) { //过滤出id相同的
          return element.categories!.contains(category.id);
        }).toList();
      },
      shouldRebuild: (prev , next) { //重新构建的条件
        return !listEquals(prev, next);
      },
      builder: (ctx,meals,child) {
        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx,index) {
            return HYMealItem(meals[index]);
          },
        );
      },
    );
  }
}
