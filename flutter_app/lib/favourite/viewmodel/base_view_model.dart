

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/favourite/viewmodel/filter_view_model.dart';

//因为meal和favourite存在很多重复代码。可以抽取基类
class BaseMealViewModel extends ChangeNotifier {
   List<HYMealModel> _meals = [];

   HYFilterViewModel _fliterVM = HYFilterViewModel();

   //更新filterVM
   void updateFilters(HYFilterViewModel filterVM) {
     _fliterVM = filterVM;
   }

   //获取过滤后的美食数组
   List<HYMealModel> get meals {
     return _meals.where((element) { //过滤条件
       if(_fliterVM.isGlutenFree && !element.isGlutenFree!) return false;
       if(_fliterVM.isLactoseFree && !element.isLactoseFree!) return false;
       if(_fliterVM.isVegetarian && !element.isVegetarian!) return false;
       if(_fliterVM.isVegan && !element.isVegan!) return false;

       return true;
     }).toList();
   }

   //获取数据源
   List<HYMealModel> get originMeals {
     return _meals;
   }

   //设置数据源，并全局通知
   set meals(List<HYMealModel> value) {
     _meals = value;
     notifyListeners();
   }
}