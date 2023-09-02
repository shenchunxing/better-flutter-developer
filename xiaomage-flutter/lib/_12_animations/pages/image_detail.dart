import 'package:flutter/material.dart';

class HYImageDetailPage extends StatelessWidget {
  final String imageURL ;

  HYImageDetailPage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          //HERO有动画
          child: Hero(tag: imageURL,child: Image.network(imageURL),),
        ),
      ),
    );
  }
}
