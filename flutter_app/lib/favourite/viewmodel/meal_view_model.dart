import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/favourite/service/meal_request.dart';
import 'package:flutter_app/favourite/viewmodel/base_view_model.dart';

//获取数据模型
class HYMealViewModel extends BaseMealViewModel {
  HYMealViewModel() {
    HYMealRequest.getMealData().then((List<HYMealModel> value) {
      meals = value;
    });
  }
}