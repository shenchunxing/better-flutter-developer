
import 'package:flutter/material.dart';

main () {
  return MaterialApp (
     home: HYStarRating(rating: 100,),
   );
}

//五角星评分控件
class HYStarRating extends StatefulWidget {
  final double rating;
  final double maxRating;
  final Widget unselectedImage;
  final Widget selectedImage;
  final int count;
  final double size;
  final unselectedColor;
  final selectedColor;

  HYStarRating({
   required this.rating,
   this.maxRating = 10,
   this.size = 30,
   this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffe0aa46),
    Widget? unselectedImage, //可选的图片
    Widget? selectedImage,
    this.count = 5,
}): unselectedImage = unselectedImage ?? Icon(Icons.star,size: size,color: unselectedColor),
        selectedImage = selectedImage ?? Icon(Icons.star,size: size,color: selectedColor);

  @override
  _HYStarRatingState createState() => _HYStarRatingState();
}

class _HYStarRatingState extends State<HYStarRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Stack(
         children: [
           //未选中的星星
           Row(children: getUnSelectImage(),mainAxisSize: MainAxisSize.min,),
           //选中的星星覆盖在未选中的上面
           Row(children: getSelectImage(),mainAxisSize: MainAxisSize.min,),
         ],
       ),
    );
  }

  // 获取评星
  List<Widget> getUnSelectImage() {
    return List.generate(widget.count, (index) {
       return widget.unselectedImage;
    });
  }

  //选中的星星
  List<Widget> getSelectImage() {
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    double leftValue = widget.rating - entireCount * oneValue;
    double leftRadio = leftValue / oneValue;//比例

    List<Widget> selectedImages = [];
    for (int i = 0 ; i < entireCount; i++) {
      selectedImages.add(widget.selectedImage);
    }

    Widget leftStar = ClipRect( //裁切
      clipper: MyRectClipper(leftRadio * widget.size),
      child: widget.selectedImage,
    );
    
    selectedImages.add(leftStar);
    
    return selectedImages;
  }
}

//剪切
class MyRectClipper extends CustomClipper<Rect> {
   final double width ; //裁切宽度
   
   MyRectClipper(this.width);
   
   @override
  getClip(Size size) {  //裁切大小
    // TODO: implement getClip
    return Rect.fromLTRB(0, 0, width, size.height);
  }
  
  @override
  bool shouldReclip(covariant MyRectClipper oldClipper) { //是否需要裁切
    // TODO: implement shouldReclip
    return width != oldClipper.width;
  }
}
