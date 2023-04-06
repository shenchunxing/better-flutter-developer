
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/_14_screenfit/int_extension.dart';

class HYDetailContent extends StatelessWidget {
  final HYMealModel _meal;
  HYDetailContent(this._meal);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( //滚动
      child: Column(
        children: [
          buildBannerImage(),
          buildMakeTitle(context, '制作材料'),
          buildMakeMaterial(context),
          buildMakeTitle(context, '制作步骤'),
          buildMakeSteps(context),
        ],
      ),
    );
  }
  // 1.横幅图片
  Widget buildBannerImage() {
    return Container(
      width: double.infinity,
      child: Image.network(_meal.imageUrl ?? ''),
    );
  }
  // 2.制作材料
  Widget buildMakeMaterial(BuildContext context) {
    return  buildMakeContent(
      context,
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,//如果滚动视图设置的是false,默认是false,那么内容会在滚动方向上尺寸延伸到最大，如果在滚动方向上没有边界约束，那么shrinkWrap必须设置为true
        physics: NeverScrollableScrollPhysics(), //ListView不滚动
        itemCount: _meal.ingredients?.length,
        itemBuilder: (ctx , index) {
          return Card(
            color: Theme.of(context).accentColor,//背景色
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Text(_meal.ingredients![index]),
            ),
          );
        },
      ),
    );
  }

  // 3.制作步骤
  Widget buildMakeSteps(BuildContext context) {
    return buildMakeContent(
      context,
      ListView.separated( //带分割线
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: _meal.steps!.length,
          itemBuilder: (ctx,index) {
            return ListTile(
              leading: CircleAvatar( //圆角
                child: Text("#${index+1}"),
              ),
              title: Text(_meal.steps![index]),//内容
            );
          },
          separatorBuilder: (ctx,index) { //分割线
            return Divider();
          },
      )
    );
  }

  Widget buildMakeTitle(BuildContext context,String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.px),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3?.copyWith(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget buildMakeContent(BuildContext context , Widget? child) {
    return Container(
      padding: EdgeInsets.all(8.px), //内边距
      decoration: BoxDecoration( //圆角
        color: Colors.white,//背景
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(color: Colors.grey), //边框
      ),
      width: MediaQuery.of(context).size.width - 30.px,//宽度
      child: child,
    );
  }
}
