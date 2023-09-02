import 'package:flutter/material.dart';

class Expandeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
         children: [
           //Flexible
           Row(
             children: <Widget>[
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
               Flexible(//Flexible 组件可以控制 Row、Column、Flex 的子控件占满父组件
                   child: Container(
                     color: Colors.red,
                     height: 50,
                   )
               ),
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
             ],
           ),
           SizedBox(height: 30,),
           Row( //第一个占1/6，第二个占2/6，第三个占3/6
             children: <Widget>[
               Flexible(
                 flex: 1,
                 child: Container(
                   color: Colors.blue,
                   alignment: Alignment.center,
                   child: Text('1 Flex/ 6 Total',style: TextStyle(color: Colors.white),),
                 ),
               ),
               Flexible(
                 flex: 2,
                 child: Container(
                   color: Colors.red,
                   alignment: Alignment.center,
                   child: Text('2 Flex/ 6 Total',style: TextStyle(color: Colors.white),),
                 ),
               ),
               Flexible(
                 flex: 3,
                 child: Container(
                   color: Colors.green,
                   alignment: Alignment.center,
                   child: Text('3 Flex/ 6 Total',style: TextStyle(color: Colors.white),),
                 ),
               ),
             ],
           ),

           SizedBox(height: 30,),
           Row(
             children: <Widget>[
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
               Flexible(
                   child: Container(
                     color: Colors.red,
                     height: 50,
                     child: Text('Container',style: TextStyle(color: Colors.white),),
                   )
               ),
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
             ],
           ),
           SizedBox(height: 30,),
           Row(
             children: <Widget>[
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
               Flexible(
                   child: Container(
                     color: Colors.red,
                     height: 50,
                     alignment: Alignment.center, //Container 默认是适配子控件大小的，但当设置对齐方式时 Container 将会填满父组件，因此是否填满剩余空间取决于子组件是否需要填满父组件。
                     child: Text('Container',style: TextStyle(color: Colors.white),),
                   )
               ),
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
             ],
           ),
           SizedBox(height: 30,),
           Row(
             children: <Widget>[
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
               Flexible(
                 child: OutlinedButton(
                   child: Text('OutlineButton'),
                   onPressed: () {},
                 ),
               ),
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
             ],
           ),
           SizedBox(height: 30,),
           Row(
             children: <Widget>[
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
               Expanded( //Expanded 必须（强制）填满剩余空间
                 child: OutlinedButton(
                   child: Text('OutlineButton'),
                   onPressed: () {},
                 ),
               ),
               Container(
                 color: Colors.blue,
                 height: 50,
                 width: 100,
               ),
             ],
           ),

           //Spacer 的本质也是 Expanded 的实现的，和Expanded的区别是：Expanded 可以设置子控件，而 Spacer 的子控件尺寸是0，因此Spacer适用于撑开 Row、Column、Flex 的子控件的空隙
           SizedBox(height: 30,),
           Row(
             children: <Widget>[
               Container(width: 100,height: 50,color: Colors.green,),
               Spacer(flex: 4,),
               Container(width: 100,height: 50,color: Colors.blue,),
               Spacer(),
               Container(width: 100,height: 50,color: Colors.red,),
             ],
           ),

           SizedBox(height: 50,),
           Container(
             color: Colors.grey.withOpacity(.5),
             alignment: Alignment.center,
             child: Container(
               height: 100,
               color: Colors.white,
               child: Row(
                 children: <Widget>[
                   SizedBox(
                     width: 15,
                   ),
                   _buildCircleImg(),
                   SizedBox(
                     width: 25,
                   ),
                   Expanded( //中间扩大
                     child: _buildCenter(),
                   ),
                   Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
                   SizedBox(
                     width: 15,
                   ),
                 ],
               ),
             ),
           )


         ],
      ),
    );
  }

  _buildCircleImg() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage('assets/images/logo.png'))),
    );
  }

  _buildCenter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('老孟Flutter', style: TextStyle(fontSize: 20),),
        Text('Flutter、Android', style: TextStyle(color: Colors.grey),)
      ],
    );
  }


}
