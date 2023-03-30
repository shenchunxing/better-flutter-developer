
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/_14_screenfit/int_extension.dart';
import 'package:flutter_app/favourite/model/category_model.dart';
import 'package:flutter_app/favourite/pages/main_screen.dart';
import 'package:flutter_app/favourite/pages/meal/meal.dart';

class HYHomeCategoryItem extends StatelessWidget {
  final HYCategoryModel _categoryModel;

  HYHomeCategoryItem(this._categoryModel);

  @override
  Widget build(BuildContext context) {
    final bgColor = _categoryModel.cColor;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.px), //圆角
            gradient: LinearGradient( //渐变色
            colors: [bgColor.withOpacity(.5),bgColor],//颜色是从0.5到1
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          _categoryModel.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold //字重
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(HYMealScreen.routeName,arguments: _categoryModel); //继续往里面传递数据
      },
    );
  }
}
