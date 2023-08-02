# Flutter Tips

### 多语言本地化
在pubspec.yaml上
```
  flutter_localizations:
    sdk: flutter
```
```
import 'package:flutter_localizations/flutter_localizations.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Deer',
      home: SplashPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US')
      ]
    );
  }
}

```

### 尽量指定文字大小以避免不必要的文字语言不同导致大小不同的问题。

### .Zone的使用
`Dart` 中可通过 `Zone` 表示指定代码执行的环境，类似一个沙盒概念，在 `Flutter` 中 **C++** 运行 `Dart` 也是在 `_runMainZoned` 内执行 `runZoned` 方法启动，而我们也可以通过 `Zone` ，在运行环境内捕获全局异常等信息:

```
  runZoned(() {
    runApp(FlutterReduxApp());
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
```
同时你可以给 `runZoned` 注册方法，在需要时执行回调，如下代码所示，这样的在一个 `Zone` 内任何地方，只要能获取 `onData` 这个 `ZoneUnaryCallback`，就都可以调用到 `handleData`
```
///最终需要处理的地方
handleData(result) {
  print("VVVVVVVVVVVVVVVVVVVVVVVVVVV");
  print(result);
}
///返回得到一个 ZoneUnaryCallback 
var onData = Zone.current.registerUnaryCallback<dynamic, int>(handleData);

///执行 ZoneUnaryCallback 返回数据
Zone.current.runUnary(onData, 2);
```
异步逻辑可以通过 `scheduleMicrotask` 可以插入异步执行方法：
```
Zone.current.scheduleMicrotask((){
  //todo something
});
```
更多可参看 ：[《Flutter完整开发实战详解(十一、全面深入理解Stream)》](https://juejin.cn/post/6844903831235461133 "https://juejin.cn/post/6844903831235461133")

##### GridView和ListView使用的时候出现上面或者下面出现空白条，Android正常，iOS底部显示有一个高度的空白条

解决办法：ListView或者GridView外层包上MediaQuery.removePadding，设置 removeTop: true， removeBottom: true即可。
```
 MediaQuery.removePadding(
    context: viewService.context,
    removeTop: true,  //移除上面空白条
    removeBottom: true,//移除下面空白条
    child: ListView.builder(
     
    ),
  );
```

##### Flutter incorrect use of parentDataWidget 异常，现象debug显示没有问题，release包不显示界面。

问题原因：Expanded Flexible等组件只能放在Row，Column，Flex的子级控件中可用空间的小部件，不能再其他组件中使用。  
解决办法：查看布局是否有Expanded Flexible布局不在Row，Column，Flex的子级控件中的情况。  
官网说明：[https://api.flutter.dev/flutter/widgets/Expanded-class.html](https://links.jianshu.com/go?to=https%3A%2F%2Fapi.flutter.dev%2Fflutter%2Fwidgets%2FExpanded-class.html)

### Widget
```
Opacity:占位，隐藏和显示
SafeArea：安全区域
AnimationContainer：动画变更
Expanded:扩充，还可以设置flex比例
```
### 拆分Widget
抽离成为函数

```
  Widget _buildText(String text){
    return Text(text, style: const TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.blue),);
  }
```
抽离成为class

```
class _MyText extends StatelessWidget {
  const _MyText(this.text, {Key key}) : super(key: key);
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.blue),);
  }
}
```
**永远不要使用方法返回的形式创建可重用的widget，始终将它们封装到StatelessWidget中**,因为class前面可以被const修饰。不会每次都rebuild，可以提高性能。

更推荐StatelessWidget的方式。正如作者说的，它具备以下优点：

- 允许性能优化（const 构造函数，更精细粒度的重建）
- 有热重载
- 集成到widget检查器中（debugFillProperties）
- 可以定义Key（关于Key的作用可以看这里的解答）
- 可以方便的使用context
- 规范所有widget以相同的方式使用（始终使用构造函数）
- 可以确保在两个不同布局之间切换时，正确的配置信息（函数可能重用一些以前的状态）
如果你之前已经写了大量的方法创建返回widget的代码，可以使用Rémi Rousselet的[functional_widget](https://github.com/rrousselGit/functional_widget)来改善这个问题。

抽离出`StatelessWidget`。其实为了避免因刷新局部widget调用`setState`而导致整个页面刷新造成的性能损耗，控制刷新范围是很必要的。

### 注意Android和iOS的差异
注意部分组件在Android与IOS平台之间的差异。
1.  `Scaffold`的 `AppBar`，`AppBar`中默认的`title`在Android中靠左显示，IOS中居中显示。如果需要两个平台效果统一，需要设置在`AppBar`中主动设置`centerTitle`属性。同时`AppBar`的返回箭头图标也不相同，统一的话需要自定义`leading`。
2.  页面跳转如果使用`MaterialPageRoute`来做过渡效果，注意Android中新的页面会从屏幕底部滑动到屏幕顶部，IOS中新的页面会从屏幕右侧滑动到屏幕左侧。如果需要两个平台效果统一，我们不使用自带效果，可以自定义一个。

```
Navigator.push(context, PageRouteBuilder(transitionDuration: Duration(milliseconds: 300),
  pageBuilder: (context, animation, secondaryAnimation){
    return new FadeTransition( //使用渐隐渐入过渡,
      opacity: animation,
      child: TestPage(),
    );
  })
);
```
要么修改`Theme`，统一两平台的实现

```
class MyApp extends StatelessWidget {
  static const Map<TargetPlatform, PageTransitionsBuilder> _defaultBuilders = <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
  };
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: _defaultBuilders
        )
      ),
      ...
    );
  }
}
```
3.ScrollPhysics效果，可以滑动的部件都有一个physics属性。滑动到边界时，Android平台为边缘阴影的效果ClampingScrollPhysics，IOS为回弹效果BouncingScrollPhysics。如果需要统一，可以指定physics属性。

4.状态栏方面，Android平台默认是半透明的效果，IOS则是透明效果。比如Android要实现IOS的效果，可以设置状态栏为透明。

```
void main(){
  runApp(MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = 
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
```
5.输入键盘
当TextField的keyboardType属性设置为TextInputType.phone 或TextInputType.number时，IOS系统弹出的数字输入键盘没有"完成"按钮，导致输入法无法关闭。当然了Android不存在这个问题。比较成熟有效的方案是在键盘弹出的上方悬浮一个按钮，点击可以关闭键盘。当然了，这种问题也有对应的库可以解决，我使用的是flutter_keyboard_actions来解决了这个问题。因为在Android端我发现了部分输入法的兼容问题，所以只针对IOS做了处理。大家可以看一下前后对比图，具体实现代码可以参考flutter_keyboard_actions的文档


### SafeArea
一旦有部件固定在顶部或者底部（严谨点的话可以说是在屏幕的四边）。那我我们最好使用`SafeArea`来包一下
```
Material( // 需要颜色填充到边界区域可以使用
  color: Colors.white,
  child: SafeArea(
    child: Container(),
  ),
)		
```
如果你觉得这样真麻烦，我给你支个大招，修改`ThemeData`的`platform`，指定一个平台
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.android
      ),
      ...
    );
  }
}
```

### KeyboardType
keyboardType属性主要含义为弹起的键盘类型，并不代表输入数据的类型。

而在Android开发中，在EditText中设置android:inputType不仅可以指定弹起的键盘类型，同时也确定了输入数据的类型，也就是内置了数据的格式校验。Flutter中并没有后者，所以可能一开始你是TextInputType.number，但是在输入法中切换成中文键盘，一样可以输入中文字符。所以数据的校验需要我们使用inputFormatters自己处理。

比如TextInputType.phone时可以使用WhitelistingTextInputFormatter 白名单校验，只允许输入0~9：

```
TextField(
      keyboardType: TextInputType.phone,
      inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))]
    )
```
输入密码时可以使用`BlacklistingTextInputFormatter` 黑名单校验，除去中文字符

```
TextField(
      keyboardType: TextInputType.text,
      inputFormatters: [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))]
    )
```
输入小数时，可以自定义`TextInputFormatter`来限制输入小数格式：

```
	TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [UsNumberTextInputFormatter()]
    )

//来源：https://www.cnblogs.com/yangyxd/p/9639588.html
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" && value != defaultDouble.toString() && strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
```

### InkWell
`InkWell`有的叫溅墨效果，有的叫水波纹效果。使用场景是给一些无点击事件的部件添加点击事件时使用（也支持长按、双击等事件），同时你也可以去修改它的颜色和形状。

```
InkWell(
  borderRadius: BorderRadius.circular(8.0), // 圆角
  splashColor: Colors.transparent, // 溅墨色（波纹色）
  highlightColor: Colors.transparent, // 点击时的背景色（高亮色）
  onTap: () {},// 点击事件
  child: Container(),
);
```
不过有时你会发现并不是包一层InkWell就一定会有溅墨效果。主要原因是溅墨效果是在一个背景效果，并不是覆盖的前景效果。所以InkWell中的child一旦有设置背景图或背景色，那么就会遮住这个溅墨效果。如果你需要这个溅墨效果，有两种方式实现。

1.包一层 Material，将背景色设置在 Material中的color里。

```
Material(
  color: Colors.white,
  child: InkWell(),
)
```
2.  使用`Stack`布局，将`InkWell`放置在上层。这种适用于给图片添加点击效果，比如Banner图的点击。

```
     Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image(),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Color(0X40FFFFFF),
                    highlightColor: Colors.transparent,
                    onTap: () {},
                  ),
                ),
              )
            ],
          )
```

### 保持页面状态
比如点击导航栏来回切换页面，默认情况下会丢失原页面状态，也就是每次切换都会重新初始化页面。这种情况解决方法就是PageView与BottomNavigationBar结合使用，同时子页面State中继承AutomaticKeepAliveClientMixin并重写wantKeepAlive为true

```
class _TestState extends State<Test> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
  @override
  bool get wantKeepAlive => true;
}
```

### setStatus
widget已经在`dispose`方法时销毁了，但在这之后却调用了`setState`方法，那么会发生此错误。比如定时器或动画回调调用`setState()`，但此时页面已关闭时，就会发生此错误。这个错误一般并不会程序崩溃，只是会造成内存的泄露
那么解决的办法分为两部分：
1.  及时停止或者销毁监听，例如一个定时器：

```
 Timer _countdownTimer;
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
```
2.  为了保险我们还要在调用`setState()`前判断当前页面是否存在：

```
  _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer){
    if (mounted){
      setState(() {
        
      });
    }
  });    
```
`mounted`在源码中是什么

```
  BuildContext get context => _element;
  StatefulElement _element;
  /// It is an error to call [setState] unless [mounted] is true.
  bool get mounted => _element != null;
```
BuildContext是Element的抽象类，你可以认为mounted 就是 context 是否存在。那么同样在回调中用到 context时，也需要判断一下mounted。比如我们要弹出一个 Dialog 时，或者在请求接口成功时退出当前页面。BuildContext的概念是比较重要，需要掌握它，错误使用一般虽不会崩溃，但是会使得代码无效。

### 监听Dialog的关闭
问题描述：我在每次的接口请求前都会弹出一个Dialog 做loading提示，当接口请求成功或者失败时关闭它。可是如果在请求中，我们点击了返回键人为的关闭了它，那么当真正请求成功或者失败关闭它时，由于我们调用了Navigator.pop(context) 导致我们错误的关闭了当前页面。

那么解决问题的突破口就是知道何时Dialog的关闭，那么就可以使用 WillPopScope 拦截到返回键的输入，同时记录到Dialog的关闭

```
  bool _isShowDialog = false;

  void closeDialog() {
    if (mounted && _isShowDialog){
      _isShowDialog = false;
      Navigator.pop(context);
    }
  }
  
  void showDialog() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog){
      _isShowDialog = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:(_) {
          return WillPopScope(
            onWillPop: () async {
              // 拦截到返回键，证明dialog被手动关闭
              _isShowDialog = false;
              return Future.value(true);
            },
            child: ProgressDialog(hintText: "正在加载..."),
          );
        }
      );
    }
  }
```

### addPostFrameCallback
`addPostFrameCallback`回调方法在Widget渲染完成时触发，所以一般我们在获取页面中的Widget大小、位置时使用到.
请求和显示Dialog不适合写在initStatus().因为可能会用到context，会导致崩溃。同时页面在build时不能调用`setState()` 或 `markNeedsBuild()`方法。所以我们需要在build完成后，才可以去创建这个新的组件
所以解决方法就是使用`addPostFrameCallback`回调方法，等待页面build完成后在请求数据
```
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_){
      /// 接口请求
    });
  }
```

### 键盘弹出和关闭

```
判断键盘是否弹出
MediaQuery.of(context).viewInsets.bottom > 0
```
`viewInsets.bottom`就是键盘的顶部距离底部的高度，也就是弹起的键盘高度。如果你想实时过去键盘的弹出状态，配合使用`didChangeMetrics`

```
import 'package:flutter/material.dart';
typedef KeyboardShowCallback = void Function(bool isKeyboardShowing);
class KeyboardDetector extends StatefulWidget {
  KeyboardShowCallback keyboardShowCallback;
  Widget content;
  KeyboardDetector({this.keyboardShowCallback, @required this.content});
  
  @override
  _KeyboardDetectorState createState() => _KeyboardDetectorState();
}

class _KeyboardDetectorState extends State<KeyboardDetector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(MediaQuery.of(context).viewInsets.bottom);
      setState(() {
        widget.keyboardShowCallback
            ?.call(MediaQuery.of(context).viewInsets.bottom > 0);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.content;
  }
}
```
弹出键盘

```
if (MediaQuery.of(context).viewInsets.bottom == 0){
  final focusScope = FocusScope.of(context);
  focusScope.requestFocus(FocusNode());
  Future.delayed(Duration.zero, () => focusScope.requestFocus(_focusNode));
}
```
关闭键盘

```
FocusScope.of(context).requestFocus(FocusNode());
/// 1.7.8 开始推荐以下方式（https://github.com/flutter/flutter/issues/7247）
FocusScope.of(context).unfocus();
/// 2020.05.14补充：更更推荐下面的方式，避免调用上面的方法造成不必要页面的rebuild。
FocusManager.instance.primaryFocus?.unfocus();
```
一般来说即使键盘弹出，点击返回页面关闭，键盘就会自动收起。但是顺序是：页面关闭 --> 键盘关闭。
这样会导致键盘短暂的出现在你的上一页面，也就会出现短暂的部件溢出

所以这时你就需要在页面关闭前手动调用关闭键盘的代码了。按道理是要放到`deactivate`或者`dispose`中处理的，可谁让`context`已经为null了，所以，老办法，拦截返回键

```
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 拦截返回键
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Container()
    );
  }   
```

### 预先缓存图片，解决滑动过程中闪一下的问题
在Flutter中，加载本地图片会存在一个加载过程。比如点击图标做图标的切换时，那么首次会发生闪动的情况。尤其是做类似引导页这类需求是，通过左右滑动切换图片时会发生比较明显的白屏一闪而过

使用 [precacheImage](https://api.flutter.dev/flutter/widgets/precacheImage.html)，它将图像预存到图像缓存中。如果图像稍后被`Image`、`BoxDecation`或`FadeInImage`使用，它会被加载得更快

```
precacheImage(AssetImage("assets/logo"), context);
```

### 限制屏幕方向，如限制竖屏

```
void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_){
    runApp(MyApp());
  });
}
```

### 插件选择
Flutter开发中的json解析确实很麻烦，当然有许多的插件来解决我们的问题。我个人推荐使用`FlutterJsonBeanFactory`

UI层面的功能最好还是使用Flutter来解决。比如Toast功能，很多人都会选择fluttertoast这个插件，而我推荐oktoast这类使用Flutter的解决方案 。因为fluttertoast是调用了Android原生的Toast，首先在各个系统上的样式就不统一，同时部分系统机型上受限通知权限，会导致Toast无法弹出。


### 善用Theme
封装也讲究使用场景。如果这种样式的部件仅仅只是某一两处使用，封装显得有点小题大做。并且封装的大而全也会增加使用的复杂度。那么这时就可以使用Theme这种办法。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fc942dcbb1294c40ba8297005ab603f6~tplv-k3u1fbpfcp-watermark.image?)
圈起来的部分有三个按钮，它们的高度相同，文字、圆角大小也相同。如果每一个都去设定这些属性，未免太过麻烦。

```
	Theme( 
              data: Theme.of(context).copyWith(
                buttonTheme: ButtonThemeData(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 64.0,
                  height: 30.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  )
                ),
                textTheme: TextTheme(
                  button: TextStyle(
                    fontSize: 14.0,
                  )
                )
              ),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    color: Color(0xFFF6F6F6),
                    onPressed: (){},
                    child: Text("联系客户"),
                  ),
                  ......
                  FlatButton(
                    color: Color(0xFFF6F6F6),
                    onPressed: (){},
                    child: Text("拒单"),
                  )
                ],
              ),
            )			
```

### 登录页面键盘弹出导致的溢出和输入框的遮挡问题

```
导致的原因就是在水平或者垂直方向上的内容超过了父部件的大小
1.  包一层`SingleChildScrollView`，让你的页面可以滑动起来。
2.  或者 在`Scaffold`中设置`resizeToAvoidBottomInset`为false。默认为ture，防止部件被遮挡。（如果使用了这个方法，如果底部有输入框，则会造成遮挡。）
详细参看
https://github.com/shenchunxing/flutter-learn/tree/master/login_app
```
### 修改状态栏文字颜色：
```
@override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(child:Scaffold(),),);
  }

```
### 收回键盘

```
  void closeKeyBoard() {
      // 触摸收起键盘（方式一）
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus &&currentFocus.focusedChild != null) {
 FocusManager.instance.primaryFocus?.unfocus();
      }
      // 触摸收起键盘（方式二）
      // FocusScope.of(context).requestFocus(FocusNode())
```