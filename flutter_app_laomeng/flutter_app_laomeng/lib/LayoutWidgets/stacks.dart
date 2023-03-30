import 'package:flutter/material.dart';

class Stacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return stacksDemo2();
  }

  Widget stacksDemo() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
              Container(
                height: 170,
                width: 170,
                color: Colors.blue,
              ),
              Container(
                height: 140,
                width: 140,
                color: Colors.yellow,
              )
            ],
          ),

        SizedBox(height: 30,),

          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
              Container(
                height: 170,
                width: 170,
                color: Colors.blue,
              ),
              Container(
                height: 140,
                width: 140,
                color: Colors.yellow,
              )
            ],
          ),

          SizedBox(height: 30,),

          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
              Container(
                height: 170,
                width: 170,
                color: Colors.blue,
              ),
              Positioned(
                left: 30,
                right: 40,
                bottom: 50,
                top: 60,
                child: Container(
                  color: Colors.yellow,
                ),
              )
            ],
          ),

          SizedBox(height: 30,),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
              Positioned(
                left: 100,
                top: 100,
                height: 150,
                width: 150,
                child: Container(
                  color: Colors.green,
                ),
              )
            ],
          ),


        ],
      ),
    );
  }

  //铺满全屏，前面的被覆盖看不到
  Widget stacksDemo2() {
   return Stack(
      fit: StackFit.expand, //尽可能大
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Container(
          height: 170,
          width: 170,
          color: Colors.blue,
        ),
        Container(
          height: 140,
          width: 140,
          color: Colors.yellow,
        )
      ],
    );
  }
}

//IndexedStack 是 Stack 的子类，Stack 是将所有的子组件叠加显示，而 IndexedStack 通过 index 只显示指定索引的子组件
class IndexedStackDemo extends StatefulWidget {
  @override
  _IndexedStackDemoState createState() => _IndexedStackDemoState();
}

class _IndexedStackDemoState extends State<IndexedStackDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50,),
        _buildIndexedStack(),
        SizedBox(height: 30,),
        _buildRow(),
      ],
    );
  }

  _buildIndexedStack() {
    return IndexedStack(
      index: _index,
      children: <Widget>[
        Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.red,
            alignment: Alignment.center,
            child: Icon(
              Icons.fastfood,
              size: 60,
              color: Colors.blue,
            ),
          ),
        ),
        Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.green,
            alignment: Alignment.center,
            child: Icon(
              Icons.cake,
              size: 60,
              color: Colors.blue,
            ),
          ),
        ),
        Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Icon(
              Icons.local_cafe,
              size: 60,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.fastfood),
          onPressed: () {
            setState(() {
              _index = 0;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.cake),
          onPressed: () {
            setState(() {
              _index = 1;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.local_cafe),
          onPressed: () {
            setState(() {
              _index = 2;
            });
          },
        ),
      ],
    );
  }
}
