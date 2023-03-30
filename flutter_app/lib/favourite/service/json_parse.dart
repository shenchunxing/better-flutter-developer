
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_app/favourite/model/category_model.dart';

//json文件解析
class HYJsonParse {
  //拿到数据
  static Future<List<HYCategoryModel>> getCategoryData() async {
    final jsonString = await rootBundle.loadString('assets/json/category.json');
    final result = json.decode(jsonString);

    final resultList = result['category'];
    List<HYCategoryModel> categories = [];
    for (var json in resultList) {
      categories.add(HYCategoryModel.fromJson(json));
    }
    return categories;
  }
}