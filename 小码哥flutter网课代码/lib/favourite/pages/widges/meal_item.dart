import 'package:flutter/material.dart';
import 'package:flutter_app/_11_router_manage/detail.dart';
import 'package:flutter_app/_14_screenfit/int_extension.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/favourite/viewmodel/favor_view_model.dart';
import 'package:flutter_app/favourite/viewmodel/meal_view_model.dart';
import 'package:provider/provider.dart';
import 'operation_item.dart';

final cardRasius = 12.px;

class HYMealItem extends StatelessWidget {
  final HYMealModel _meal;

  HYMealItem(this._meal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(10.px),
        elevation: 5,//卡片阴影
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRasius)),//圆角
        child: Column(
          children: [
            buildBasicInfo(context),
        buildOperationInfo()
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(HYDetailPage.routerName,arguments: _meal);
      },
    );
  }

  //图片
  Widget buildBasicInfo(BuildContext context) {
    return Stack(
      children: [
        ClipRRect( //圆角裁剪
          borderRadius: BorderRadius.only( //只裁剪左上和右上
            topLeft: Radius.circular(cardRasius),
            topRight: Radius.circular(cardRasius),
          ),
          child: Image.network(_meal.imageUrl ?? '',width: double.infinity,height: 250.px,fit: BoxFit.cover,),
        ),
        Positioned(
          right: 10.px,//距右侧和底部10
          bottom: 10.px,
          child: Container(
            width: 300.px,
            padding: EdgeInsets.symmetric(horizontal: 10.px,vertical: 5.px),
            decoration: BoxDecoration(
              color: Colors.black54, //背景色
              borderRadius: BorderRadius.circular(6.px),
            ),
            child: Text(_meal.title ?? '',style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),),
          ),
        ),
      ],
    );
  }

  Widget buildOperationInfo() {
    return Padding(
      padding: EdgeInsets.all(16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, //布局方式
        children: [
        HYOperationItem(Icon(Icons.schedule),'${_meal.duration}分钟'),//分钟
        HYOperationItem(Icon(Icons.restaurant),'${_meal.complexStr}'),//简单
          buildFavorItem()//收藏
    ]
      ),
    );
  }

  Widget buildFavorItem() {
     return Consumer<HYFavorViewModel>(
       builder: (ctx , favorVM,child) {
         // 1.判断是否收藏状态
         final iconData = favorVM.isFavor(_meal) ? Icons.favorite: Icons.favorite_border;
     final favorColor = favorVM.isFavor(_meal) ? Colors.red: Colors.black;
     final title = favorVM.isFavor(_meal)? "收藏": "未收藏";
     return GestureDetector(
        child: HYOperationItem(
          Icon(iconData,color: favorColor,),
          title,
        ),
       onTap: () {
         favorVM.handleMeal(_meal);
       },
     );
     },
     );
  }
}

