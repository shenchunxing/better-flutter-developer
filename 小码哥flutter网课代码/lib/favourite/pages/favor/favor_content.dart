
import 'package:flutter_app/favourite/pages/widges/meal_item.dart';
import 'package:flutter_app/favourite/viewmodel/favor_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class HYFavorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HYFavorViewModel>(
      builder: (ctx,favorVM, child) {
        //没有任何收藏
        if (favorVM.originMeals.length == 0) {
          return Center(child: Text('未收藏美食'),);
        }
        return ListView.builder(
          itemCount: favorVM.originMeals.length,
          itemBuilder: (ctx,index) {
            return HYMealItem(favorVM.originMeals[index]);
          },
        );
      },
    );
  }
}
