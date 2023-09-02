import 'package:flutter/material.dart';

class Imagess extends StatefulWidget {
  @override
  _ImagessState createState() => _ImagessState();
}

class _ImagessState extends State<Imagess> {
  @override
  Widget build(BuildContext context) {
    return imagesDemo2();
  }

  Widget imagesDemo1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg',
          ),
          Image.asset(
            'assets/images/aa.jpg',
            width: 150,
            height: 150,
            fit: BoxFit.none,
            alignment: Alignment.centerRight, //裁剪和alignment相关
          ),
          Container(
            color: Colors.red.withOpacity(.3),
            child: Image.asset(
              'assets/images/aa.jpg',
              width: 150,
              height: 150,
              alignment: Alignment.centerLeft,
            ),
          ),

          Image.asset('assets/images/aa.jpg'),
          Image.asset('assets/images/aa.jpg',width: 100,height: 200,),
          Container(
            color: Colors.red.withOpacity(.3),
            child: Image.asset('assets/images/aa.jpg',width: 150,height: 150),
          ),
          Container(
            color: Colors.red.withOpacity(.3),
            child: Image.asset('assets/images/aa.jpg',width: 150,height: 150,fit: BoxFit.fill,),
          ),
          Container(
            color: Colors.red.withOpacity(.3),
            child: Image.asset('assets/images/aa.jpg',width: 150,height: 150,fit: BoxFit.cover,),
          ),
          Image.asset(
            'assets/images/aa.jpg',
            width: double.infinity,
            height: 150,
            repeat: ImageRepeat.repeatX,
          )
        ],
      ),
    );
  }

  Widget imagesDemo2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Directionality( //倒转
              textDirection: TextDirection.rtl,
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
                matchTextDirection: true,
              )),
          Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
            //构建
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity( //动画
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
              );
            },
          ),

          //loadingBuilder可以控制进度条
          Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
              //loadingBuilder可以控制进度条
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }),

          //chat聊天框，图有问题，导致显示不出来
          Container(
            width: 200,
            padding: EdgeInsets.only(left: 8,top: 8,right: 20,bottom: 8),
            decoration: BoxDecoration(
                image: DecorationImage(
                    centerSlice: Rect.fromLTWH(20, 20, 1, 1),
                    image: AssetImage(
                      'assets/images/chat.png',
                    ),
                    fit: BoxFit.fill)),
            child: Text('老孟，专注分享Flutter技术和应用实战。'
                '老孟，专注分享Flutter技术和应用实战。'
                '老孟，专注分享Flutter技术和应用实战。',),
          ),

          //圆角头像
          Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(3),//边框大小
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/aa.jpg'), fit: BoxFit.cover)),
            ),
          ),
          Container( //报错：centerSlice was used with a BoxFit that does not guarantee that the image is fully visible.，因为这是由于图片比组件的尺寸大，如果使用centerSlice属性，图片必须比组件的尺寸小，一般情况下，.9图的尺寸都非常小。
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    //centerSlice用于.9图，.9图用于拉伸图片的特定区域，centerSlice设置的区域（Rect）就是拉伸的区域。.9图通常用于控件大小、宽高比不固定的场景
                      centerSlice: Rect.fromLTWH(20, 20, 10, 10),
                      image: AssetImage(
                        'assets/images/abc.jpg',
                      ),
                      fit: BoxFit.fill))),

          //占位图
          Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
            height: 150,
            width: 150,
            fit: BoxFit.cover,
            frameBuilder: (
                BuildContext context,
                Widget child,
                int? frame,
                bool wasSynchronouslyLoaded,
                ) {
              if (frame == null) {
                return Image.asset(
                  'assets/images/place.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                );
              }
              return child;
            },
          )
        ],
      ),
    );
  }
}
