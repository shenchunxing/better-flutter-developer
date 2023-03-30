
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'http_request.dart';

class HYMealRequest{
  static Future<List<HYMealModel>> getMealData() async {
    final String url = '/meal';
    final resut = await HttpRequest.request(url);

    final mealArray = resut['meal'];
    List<HYMealModel> meals = [];
    for (var json in mealArray) {
      meals.add(HYMealModel.fromJson(json));
    }

    return meals;
  }
}