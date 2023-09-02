
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/favourite/viewmodel/base_view_model.dart';

class HYFavorViewModel extends BaseMealViewModel {
//添加收藏
  void addMeal(HYMealModel meal) {
    originMeals.add(meal);
    notifyListeners();
  }

  //移除收藏
  void removeMeal(HYMealModel meal) {
    originMeals.remove(meal);
    notifyListeners();
  }

  //如果已经收藏则取消收藏，否则收藏
  void handleMeal(HYMealModel meal) {
    if (isFavor(meal)) {
      removeMeal(meal);
    } else {
      addMeal(meal);
    }
  }

  //是否被收藏了
  bool isFavor(HYMealModel meal) {
    return originMeals.contains(meal);
  }
}