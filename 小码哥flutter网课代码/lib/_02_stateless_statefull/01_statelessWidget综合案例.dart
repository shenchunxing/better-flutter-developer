import 'package:flutter/material.dart';

void main() {
  runApp(StlApp());
}
class StlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表 '),
      ),
      body: HYHomeContent(),
    );
  }
}

class HYHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HYHomeProductItem("Apple1", "Macbook1", "https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg"),
        SizedBox(height: 6,),
        HYHomeProductItem("Apple2", "Macbook2", "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imm9u5zj30u00k0adf.jpg"),
        SizedBox(height: 6,),
        HYHomeProductItem("Apple3", "Macbook2", "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imqlouhj30u00k00v0.jpg"),
      ],
    );
  }
}

class HYHomeProductItem extends StatelessWidget {
  final String title;
  final String desc;
  final String imageURL;

  final style1 = TextStyle(fontSize: 25,color: Colors.orange);
  final style2 = TextStyle(fontSize: 20,color: Colors.green);

  HYHomeProductItem(this.title,this.desc,this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),//间距
      decoration: BoxDecoration( // 设置边框的宽度 颜色
        border: Border.all(width: 15,color: Colors.pink),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,//主轴居中
        crossAxisAlignment: CrossAxisAlignment.end, //交叉轴据右
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,style: style1,),
              Text(title,style: style2,),
            ],
          ),
          SizedBox(height: 5,),
          Text(desc,style: style2,),
          SizedBox(height: 5,),
          Image.network(imageURL),//网络加载
        ],
      ),
    );
  }
}
