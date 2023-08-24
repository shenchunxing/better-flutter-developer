
热重载
热重载是指，在不中断App正常运行的情况下，动态注入修改后的代码片段。而这一切的背后，离不开Flutter所提供的运行时编译能力。为了更好地理解Flutter的热重载实现原理，我们先简单回顾一下Flutter编译模式背后的技术吧。
* JIT（Just In Time），指的是即时编译或运行时编译，在Debug模式中使用，可以动态下发和执行代码，启动速度快，但执行性能受运行时编译影响；

图1 JIT编译模式示意图
* AOT（Ahead Of Time），指的是提前编译或运行前编译，在Release模式中使用，可以为特定的平台生成稳定的二进制代码，执行性能好、运行速度快，但每次执行均需提前编译，开发调试效率低。

图2 AOT编译模式示意图
可以看到，Flutter提供的两种编译模式中，AOT是静态编译，即编译成设备可直接执行的二进制码；而JIT则是动态编译，即将Dart代码编译成中间代码（Script Snapshot），在运行时设备需要Dart VM解释执行。
而热重载之所以只能在Debug模式下使用，是因为Debug模式下，Flutter采用的是JIT动态编译（而Release模式下采用的是AOT静态编译）。JIT编译器将Dart代码编译成可以运行在Dart VM上的Dart Kernel，而Dart Kernel是可以动态更新的，这就实现了代码的实时更新功能。

图3 热重载流程
总体来说，热重载的流程可以分为扫描工程改动、增量编译、推送更新、代码合并、Widget重建5个步骤：
1. 工程改动。热重载模块会逐一扫描工程中的文件，检查是否有新增、删除或者改动，直到找到在上次编译之后，发生变化的Dart代码。
2. 增量编译。热重载模块会将发生变化的Dart代码，通过编译转化为增量的Dart Kernel文件。
3. 推送更新。热重载模块将增量的Dart Kernel文件通过HTTP端口，发送给正在移动设备上运行的Dart VM。
4. 代码合并。Dart VM会将收到的增量Dart Kernel文件，与原有的Dart Kernel文件进行合并，然后重新加载新的Dart Kernel文件。
5. Widget重建。在确认Dart VM资源加载成功后，Flutter会将其UI线程重置，通知Flutter Framework重建Widget。
可以看到，Flutter提供的热重载在收到代码变更后，并不会让App重新启动执行，而只会触发Widget树的重新绘制，因此可以保持改动前的状态，这就大大节省了调试复杂交互界面的时间。
比如，我们需要为一个视图栈很深的页面调整UI样式，若采用重新编译的方式，不仅需要漫长的全量编译时间，而为了恢复视图栈，也需要重复之前的多次点击交互，才能重新进入到这个页面查看改动效果。但如果是采用热重载的方式，不仅没有编译时间，而且页面的视图栈状态也得以保留，完成热重载之后马上就可以预览UI效果了，相当于局部界面刷新。
不支持热重载的场景
Flutter提供的亚秒级热重载一直是开发者的调试利器。通过热重载，我们可以快速修改UI、修复Bug，无需重启应用即可看到改动效果，从而大大提升了UI调试效率。
不过，Flutter的热重载也有一定的局限性。因为涉及到状态保存与恢复，所以并不是所有的代码改动都可以通过热重载来更新。
接下来，我就与你介绍几个不支持热重载的典型场景：
* 代码出现编译错误；
* Widget状态无法兼容；
* 全局变量和静态属性的更改；
* main方法里的更改；
* initState方法里的更改；
* 枚举和泛类型更改。
现在，我们就具体看看这几种场景的问题，应该如何解决吧。
代码出现编译错误
当代码更改导致编译错误时，热重载会提示编译错误信息。比如下面的例子中，代码中漏写了一个反括号，在使用热重载时，编译器直接报错：

Initializing hot reload...
Syncing files to device iPhone X...

Compiler message:
lib/main.dart:84:23: Error: Can't find ')' to match '('.
    return MaterialApp(
                      ^
Reloaded 1 of 462 libraries in 301ms.

在这种情况下，只需更正上述代码中的错误，就可以继续使用热重载。
Widget状态无法兼容
当代码更改会影响Widget的状态时，会使得热重载前后Widget所使用的数据不一致，即应用程序保留的状态与新的更改不兼容。这时，热重载也是无法使用的。
比如下面的代码中，我们将某个类的定义从 StatelessWidget改为StatefulWidget时，热重载就会直接报错：

//改动前
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => print('T'));
  }
}

//改动后
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => MyWidgetState();
}
class MyWidgetState extends State<MyWidget> { /*...*/ }

当遇到这种情况时，我们需要重启应用，才能看到更新后的程序。
全局变量和静态属性的更改
在Flutter中，全局变量和静态属性都被视为状态，在第一次运行应用程序时，会将它们的值设为初始化语句的执行结果，因此在热重载期间不会重新初始化。
比如下面的代码中，我们修改了一个静态Text数组的初始化元素。虽然热重载并不会报错，但由于静态变量并不会在热重载之后初始化，因此这个改变并不会产生效果：

//改动前
final sampleText = [
  Text("T1"),
  Text("T2"),
  Text("T3"),
  Text("T4"),
];

//改动后
final sampleText = [
  Text("T1"),
  Text("T2"),
  Text("T3"),
  Text("T10"),    //改动点
];

如果我们需要更改全局变量和静态属性的初始化语句，重启应用才能查看更改效果。
main方法里的更改
在Flutter中，由于热重载之后只会根据原来的根节点重新创建控件树，因此main函数的任何改动并不会在热重载后重新执行。所以，如果我们改动了main函数体内的代码，是无法通过热重载看到更新效果的。
举例:
//更新前
class MyAPP extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return const Center(child: Text('Hello World', textDirection: TextDirection.ltr));
  }
}

void main() => runApp(new MyAPP());

//更新后
void main() => runApp(const Center(child: Text('Hello, 2019', textDirection: TextDirection.ltr)));

由于main函数并不会在热重载后重新执行，因此以上改动是无法通过热重载查看更新的。
initState方法里的更改
在热重载时，Flutter会保存Widget的状态，然后重建Widget。而initState方法是Widget状态的初始化方法，这个方法里的更改会与状态保存发生冲突，因此热重载后不会产生效果。
在下面的例子中，我们将计数器的初始值由10改为100：

//更改前
class _MyHomePageState extends State<MyHomePage> {
  int _counter;
  @override
  void initState() {
    _counter = 10;
    super.initState();
  }
  ...
}

//更改后
class _MyHomePageState extends State<MyHomePage> {
  int _counter;
  @override
  void initState() {
    _counter = 100;
    super.initState();
  }
  ...
}

由于这样的改动发生在initState方法中，因此无法通过热重载查看更新，我们需要重启应用，才能看到更改效果。
枚举和泛型类型更改
在Flutter中，枚举和泛型也被视为状态，因此对它们的修改也不支持热重载。比如在下面的代码中，我们将一个枚举类型改为普通类，并为其增加了一个泛型参数：

//更改前
enum Color {
  red,
  green,
  blue
}

class C<U> {
  U u;
}

//更改后
class Color {
  Color(this.r, this.g, this.b);
  final int r;
  final int g;
  final int b;
}

class C<U, V> {
  U u;
  V v;
}

这两类更改都会导致热重载失败，并生成对应的提示消息。同样的，我们需要重启应用，才能查看到更改效果。
