
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/favourite/viewmodel/favor_view_model.dart';

class HYDetailFloatingButton extends StatelessWidget {
  final HYMealModel _meal;

  HYDetailFloatingButton(this._meal);

  @override
  Widget build(BuildContext context) {
    //需要共享数据Consumer
    return Consumer<HYFavorViewModel>(builder: (ctx,favorVM,child) {
      final iconData = favorVM.isFavor(_meal) ? Icons.favorite : Icons.favorite_border;
      final  iconColor = favorVM.isFavor(_meal) ? Colors.red : Colors.black;
      return FloatingActionButton(
        child: Icon(iconData,color: iconColor,),
        onPressed: () { //收藏/取消收藏
          favorVM.handleMeal(_meal);
        },
      );
    });
  }
}
