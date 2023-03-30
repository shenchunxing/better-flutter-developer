import 'package:flutter/material.dart';
import 'package:flutter_app/_12_animations/pages/image_detail.dart';
import 'package:flutter_app/_12_animations/pages/model_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'),),
      body: Center(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 16 / 9
          ),
          children: List.generate(20, (index) {

            final imageURL = "https://picsum.photos/500/500?random=$index";
            return GestureDetector(
              onTap: () {
                //push动画
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (ctx , anim1,anim2) {
                    return FadeTransition(opacity: anim1,child: HYImageDetailPage(imageURL),);
                  }
                ));
              },
              child: Hero(
                tag: imageURL,
                child: Image.network(imageURL,fit: BoxFit.cover,),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pool),
        onPressed: () {
          //ios presenter方式fullscreenDialog = true
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) {
                     return HYModalPage();
                     },
                  fullscreenDialog: true
              )
          );

//        Navigator.of(context).push(PageRouteBuilder(
//           transitionDuration: Duration(seconds: 3),//动画时间
//            pageBuilder: (ctx , anim1 , anim2) {
//             //3秒内完成页面动画的切换
//              return FadeTransition(opacity: anim1,child: HYModalPage(),);
            },

        ),
    );
  }
}
