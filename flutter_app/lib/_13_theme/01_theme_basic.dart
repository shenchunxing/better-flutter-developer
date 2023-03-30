import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/_11_router_manage/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /**
   * 1.一旦设置了主题, 那么应用程序中的某些Widget, 就会直接使用主题的样式
   * 2.可以通过Theme.of(context).textTheme.display2
   */

  // MaterialColor extends Color
  // 父类的引用指向一个子类的对象
//    Color color = Colors.orangeAccent;

  // 子类的引用指向父类的对象;
  // MaterialColor color = Color(0xff000000);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      // 全局主题
      theme: ThemeData(
        // 1.亮度
        brightness: Brightness.light,
        // 3.primaryColor: 单独设置导航和TabBar的颜色
        primaryColor: Colors.orange,
        // 2.primarySwatch传入不是Color, 而是MaterialColor(包含了primaryColor和accentColor)
        primarySwatch: Colors.red,
        // 4.accentColor: 单独设置FloatingActionButton\Switch
        accentColor: Colors.green,
        // 5.Button的主题
        buttonTheme: ButtonThemeData(
          height: 25,
          minWidth: 20,
          buttonColor: Colors.yellow,
        ),
        // 6.Card的主题
        cardTheme: CardTheme(
          color: Colors.greenAccent,
          elevation: 10,
        ),
        // 7.Text的主题
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16,color: Colors.red),
          bodyText2: TextStyle(fontSize: 10),
          headline1: TextStyle(fontSize: 14),
          headline2: TextStyle(fontSize: 16),
          headline3: TextStyle(fontSize: 18),
        ),
      ),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('shouye'),),
      body: Center(
        child: Column(
          children: [
            Text('hello world'),
            Text('hello world',style: TextStyle(fontSize: 14),),
            Text('hello world',style: TextStyle(fontSize: 18),),
            Text('hello world',style: Theme.of(context).textTheme.bodyText2,),
            Text('hello world',style: Theme.of(context).textTheme.headline2,),
            Switch(value: false,onChanged: (value) {},),
            CupertinoSwitch(value: true, onChanged: (value) {},activeColor: Colors.red,),//ios 风格
            RaisedButton(onPressed: (){},child: Text('R'),),
            Card(child: Text('你好啊，李银河',style: TextStyle(fontSize: 50),),)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar( //TAB BAR
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: '分类'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return HYDetailPage();
          }));
        },
      ),
    );
  }
}

class HYDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(//Scaffold单独设置主题
      data: Theme.of(context).copyWith(primaryColor: Colors.purple),
      child: Scaffold(
        appBar: AppBar(title: Text('详情页'),backgroundColor: Colors.purple,),
        body: Center(child: Text('detail page',style: TextStyle(fontSize: 40),),),
        floatingActionButton: Theme( //floatingActionButton单独设置按钮主题
          data: Theme.of(context).copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(
            secondary: Colors.pink
          ),),
          child: FloatingActionButton(
            child: Icon(Icons.pets,color: Colors.green,),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
