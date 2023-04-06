import 'package:flutter/material.dart';

class PageViews extends StatefulWidget {
  @override
  _PageViewsState createState() => _PageViewsState();
}

class _PageViewsState extends State<PageViews> {
  var imgList = [
    'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg',
    'https://img1.baidu.com/it/u=3622442929,3246643478&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1667062800&t=3297501921b6959dd28c455e88c4fe8a',
    'https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1667062800&t=c5c13b1d5ed6a1f53adad024e9fe2dbd',
  ];
  late PageController _pageController;
  List<String> pageList = ['PageView1', 'PageView2', 'PageView3'];
  int _currentPageIndex = 0; //当前页
  double _scaleFactor = .8; //缩放系数
  double _height = 230.0; //高度
  double _currPageValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page as double;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: _height,
          child: PageView.builder(itemBuilder: (context, index) {
            return _buildPageItem(index);
          }, itemCount: 1000, controller: _pageController,onPageChanged: (int index) {
            _currentPageIndex = index % pageList.length;
          } ,),
        ),

        Positioned( //设置上下左右
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,//设置居中
              //3个圆点
              children: List.generate(pageList.length, (i) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5), //内间距
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,//圆形
                      color: _currentPageIndex == i
                          ? Colors.blue //选中颜色
                          : Colors.grey),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  //每一页
  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      //当前的item
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currPageValue.floor() + 1) {
      //右边的item
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currPageValue.floor() - 1) {
      //左边
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else {
      //其他，不在屏幕显示的item
      matrix4 = Matrix4.diagonal3Values(1.0, _scaleFactor, 1.0)
        ..setTranslationRaw(0.0, _height * (1 - _scaleFactor) / 2, 0.0);
    }

    return Stack(
      children: [
        Transform(
          transform: matrix4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(imgList[index % pageList.length]), fit: BoxFit.fill),
              ),
            ),
          ),
        ),

        _buildPageViewText(pageList[index % pageList.length]),
      ],
    );
  }

  //每一页的文字
  _buildPageViewText(String txt, {Color color = Colors.red}) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        color: color,
        alignment: Alignment.center,
        child: Text(
          txt,
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
    );
  }
}

