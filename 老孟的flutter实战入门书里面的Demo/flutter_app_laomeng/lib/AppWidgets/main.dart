import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home.dart';
import 'book.dart';
import 'me.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  // This widget is the root of your application.
  int _currentIndex = 0;
  List<Widget> pages = [Home(),Book(),Me()];
  Widget _currentPage = Home();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      //路由
      routes: {},
      initialRoute: '/',
      onGenerateRoute: (RouteSettings routeSettings){

      },
      onUnknownRoute: (RouteSettings routeSettings){
      },

      //主题
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
          primaryColor: Colors.red
      ),
      themeMode: ThemeMode.dark,

      //国际化
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,//为Material Components库提供了本地化的字符串和其他值
        GlobalWidgetsLocalizations.delegate,//定义widget默认的文本方向，从左到右或从右到左
        GlobalCupertinoLocalizations.delegate//为Cupertino（ios风格）库提供了本地化的字符串和其他值
      ],
      //支持的语言
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],

      //切换语言的监听
      localeListResolutionCallback: (locales, Iterable<Locale> supportedLocales) {
        if (locales!.contains('zh')) {
          return Locale('zh');
        }
        return Locale('en');//默认英文
      },

//      debugShowMaterialGrid: true, //网格调试
//      showPerformanceOverlay: true, //性能检测
      debugShowCheckedModeBanner: true,

      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
          iconTheme:IconThemeData(size: 24),
          actionsIconTheme: IconThemeData(size: 24),
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.purple)),//指定主题风格
//          leading: BackButton(),
          centerTitle: false,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.red,
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(icon: Icon(Icons.menu),onPressed: () {
                Scaffold.of(context).openDrawer();
              },);
            }),
            Builder(builder: (context) {
              return IconButton(icon: Icon(Icons.star),onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: '确定',
                    onPressed: () {
                      print('确定');
                    },
                  ),
                  content: Row(
                    children: <Widget>[
                      Icon(Icons.check,color: Colors.green,),
                      Text('下载成功')],
                  ),
//                  behavior: SnackBarBehavior.floating, //弹出方式
                ));
              },);
            }),
            IconButton(icon: Icon(Icons.add),onPressed: (){},)
          ],
            bottom: TabBar(
              tabs: <Widget>[
                Text('语文'),
                Text('数学'),
                Text('英语'),
                Text('体育'),
                Text('音乐'),
              ],
              controller: TabController(length: 5, vsync: this),
            ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(textColor: Colors.purple,title: Text('1'),),
              ListTile(textColor: Colors.purple,title: Text('2')),
              ListTile(textColor: Colors.purple,title: Text('3')),
              ListTile(textColor: Colors.purple,title: Text('4')),
            ],
          ),
        ),
        endDrawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(
//          type:BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            _currentPage = pages[index];
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: '首页',icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '书籍',icon: Icon(Icons.book)),
            BottomNavigationBarItem(label: '我的',icon: Icon(Icons.perm_identity)),
          ],
        ),
        body: Builder(
          builder: (context) {
            return _currentPage;
          },
        ),

        persistentFooterButtons: <Widget>[
          FlatButton(onPressed: (){},child: Text('FlatButton1'),),
          FlatButton(onPressed: (){},child: Text('FlatButton2'),),
          FlatButton(onPressed: (){},child: Text('FlatButton3'),),
        ],
        bottomSheet: BottomSheet(
            enableDrag: false, //是否可以拖动，默认为 true
            onClosing: () {
              print('onClosing click');
            },
            backgroundColor: Colors.lightBlue,
            builder: (context) {
              return Container(
                color: Colors.cyan,
                height: 150,
                alignment: Alignment.center,
                child: Text('BottomSheet'),
              );
            }),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed: () {

        },),
      ),
    );
  }
}
