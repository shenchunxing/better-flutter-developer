import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/category_model.dart';
import 'package:flutter_app/favourite/pages/home/home_category_item.dart';
import 'package:flutter_app/favourite/service/json_parse.dart';
import 'package:flutter_app/_14_screenfit/int_extension.dart';

class HYHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //未来请求FutureBuilder：拿到网络请求的数据再构建
    return FutureBuilder<List<HYCategoryModel>> (
      future: HYJsonParse.getCategoryData(), //获取数据
      builder: (ctx , snapshot) {//snapshot快照
        if (!snapshot.hasData) return Center( //没有数据，显示加载中
          child: CircularProgressIndicator(), //圆形加载器
        );
        if (snapshot.error != null) return Center(child: Text('请求失败'),); //请求失败

        //数据源
        final categories = snapshot.data;

        return GridView.builder ( //返回数据
          padding: EdgeInsets.all(20.px),
          itemCount: categories?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
            crossAxisCount: 2,
            crossAxisSpacing: 20.px,
            mainAxisSpacing: 20.px,
            childAspectRatio: 1.5
          ),
          itemBuilder: (ctx , index) {
            return HYHomeCategoryItem(categories![index]); //模型传进去赋值
          },
        );
      },
    );
  }
}
