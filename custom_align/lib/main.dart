import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: SizedBox(
        child: CustomAlign(
          alignment: Alignment.center,
          child: Text('文件传输中'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class CustomAlign extends SingleChildRenderObjectWidget {
  /*对齐*/
  final Alignment alignment;

  const CustomAlign({Key? key, Widget? child, this.alignment = Alignment.topLeft})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return AlignRenderBox(alignment: alignment);
  }

  /*更新AlignRenderBox*/
  @override
  void updateRenderObject(
      BuildContext context, covariant AlignRenderBox renderObject) {
    renderObject.alignment = alignment;
  }
}

class AlignRenderBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  Alignment? alignment;

  AlignRenderBox({RenderBox? child, this.alignment}) {
    this.child = child;
  }

  @override
  void performLayout() {
    ///super.performLayout(); 要注意千万不要调用super.performLayout()
    if (child == null) {
      size = Size.zero;
      ///没有child则不占用控件
    } else {
      size = constraints.constrain(Size.infinite); //尽可能填满
      child?.layout(constraints.loosen(), parentUsesSize: true); //不对child的大小进行限制
      BoxParentData parentData = child?.parentData as BoxParentData;
      parentData.offset = alignment!.alongOffset(size - child!.size as Offset); //设置偏移
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    if (child != null) {
      //如果child不为空 绘制child 并为child指定offset
      BoxParentData parentData = child?.parentData as BoxParentData;
      context.paintChild(child!, offset + parentData.offset);
    }
  }
}
