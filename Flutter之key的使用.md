# Flutter之Key
`Key`是`Widget`、`Element`和`SemanticsNode`的标识符。 只有当新的`Widget`的`Key`与当前`Element`中`Widget`的`Key`相同时，它才会被用来更新现有的`Element`。 `Key`在具有相同父级的`Element`之间必须是唯一的。

```
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    widgets = [
      StatelessColorfulTile(),
      StatelessColorfulTile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: widgets,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _swapTile,
      ),
    );
  }

  _swapTile() {
    setState(() {
      widgets.insert(1, widgets.removeAt(0));
    });
  }
}

class StatelessColorfulTile extends StatelessWidget {
  final Color _color = Utils.randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      color: _color,
    );
  }
}

class Utils {
  static Color randomColor() {
    var red = Random.secure().nextInt(255);
    var greed = Random.secure().nextInt(255);
    var blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }
}
```
效果很简单，就是两个彩色方块，点击右下角的按钮后交换两个方块的位置。这里我就不放具体的效果图了。实际效果也和我们预期的一样，两个方块成功交换位置。

### 发现问题
上面的方块是`StatelessWidget`，那我们把它换成`StatefulWidget`呢

```
class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile({Key key}) : super(key: key);

  @override
  StatefulColorfulTileState createState() => StatefulColorfulTileState();
}

class StatefulColorfulTileState extends State<StatefulColorfulTile> {
  final Color _color = Utils.randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      color: _color,
    );
  }
}
```
再次执行代码，发现方块没有“交换”。这是为什么？

### 分析
Flutter中有三棵树，分别是Widget Tree、Element Tree 和 RenderObject Tree。

Widget： Element 的配置信息。与Element的关系可以是一对多，一份配置可以创造多个Element实例。
Element：Widget 的实例化，内部持有Widget和RenderObject。
RenderObject：负责渲染绘制。
简单的比拟一下，Widget有点像是产品经理，规划产品整理需求。Element则是UI小姐姐，根据原型整理出最终设计图。RenderObject就是我们程序员，负责具体的落地实现。

代码中可以确定一点，两个方块的Widget肯定是交换了。既然Widget没有问题，那就看看Element。

但是为什么StatelessWidget可以成功，换成StatefulWidget就失效了？

点击按钮调用setState方法，依次执行：

![截屏2023-03-31 09.20.32.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2a4f60ebda304c13849b341891c3e626~tplv-k3u1fbpfcp-watermark.image?)
重点看一下`Element`的`updateChild`方法

```  
@protected
  Element updateChild(Element child, Widget newWidget, dynamic newSlot) {
      // 如果'newWidget'为null，而'child'不为null，那么我们删除'child'，返回null。
    if (newWidget == null) {
      if (child != null)
        deactivateChild(child);
      return null;
    }
    if (child != null) {
      // 两个widget相同，位置不同更新位置，返回child。这里比较的是hashCode
      if (child.widget == newWidget) {
        if (child.slot != newSlot)
          updateSlotForChild(child, newSlot);
        return child;
      }
      // 我们的交换例子处理在这里
      if (Widget.canUpdate(child.widget, newWidget)) {
        if (child.slot != newSlot)
          updateSlotForChild(child, newSlot);
        child.update(newWidget);
        return child;
      }
      deactivateChild(child);
    }
    // 如果无法更新复用，那么创建一个新的Element并返回。
    return inflateWidget(newWidget, newSlot);
  }
```
`Widget`的`canUpdate`方法：

```  
static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
```
canUpdate方法的作用是判断newWidget是否可以替代oldWidget作为Element的配置。 一开始也提到了，Element会持有Widget。

该方法判断的依据就是runtimeType和key是否相等。在我们上面的例子中，不管是StatelessWidget还是StatefulWidget的方块，显然canUpdate都会返回true。因此执行child.update(newWidget)方法，就是将持有的Widget更新了。

不知道这里大家有没有注意到，这里并**没有更新`state`**。我们看一下`StatefulWidget`源码

```
abstract class StatefulWidget extends Widget{
  const StatefulWidget({ Key key }) : super(key: key);
  
  @override
  StatefulElement createElement() => StatefulElement(this);

  @protected
  State createState();
}
```
`StatefulWidget`中创建的是`StatefulElement`，它是`Element`的子类。

```
class StatefulElement extends ComponentElement {

  StatefulElement(StatefulWidget widget)
      : _state = widget.createState(),
        super(widget) {
    _state._element = this;  
    _state._widget = widget;
  }

  @override
  Widget build() => state.build(this);

  State<StatefulWidget> get state => _state;
  State<StatefulWidget> _state;//这里持有state
  ...
}
```
通过调用`StatefulWidget`的`createElement`方法，最终执行`createState`创建出state并持有。也就是说`StatefulElement`才持有state。

所以我们上面两个`StatefulWidget`的方块的交换，实际只是交换了“身体”(widget)，而“灵魂”没有交换(state)。所以不管你怎么点击按钮都是没有变化的。

### 解决

设置不同的key
```
@override
  void initState() {
    super.initState();
    widgets = [
      StatefulColorfulTile(key: const Key("1")),
      StatefulColorfulTile(key: const Key("2"))
    ];
  }
```
但是这里要注意的是，这里不是说添加key以后，在`canUpdate`方法返回false，最后执行`inflateWidget(newWidget, newSlot)`方法创建新的`Element`。

```
  @protected
  Element inflateWidget(Widget newWidget, dynamic newSlot) {
    final Key key = newWidget.key;
    if (key is GlobalKey) {
      final Element newChild = _retakeInactiveElement(key, newWidget);
      if (newChild != null) {
        newChild._activateWithParent(this, newSlot);
        final Element updatedChild = updateChild(newChild, newWidget, newSlot);
        assert(newChild == updatedChild);
        return updatedChild;
      }
    }
    // 这里就调用到了createElement，重新创建了Element
    final Element newChild = newWidget.createElement();
    newChild.mount(this, newSlot);
    return newChild;
  }
```
如果如此，那么执行`createElement`方法势必会重新创建state，那么方块的颜色也就随机变了。当然此种情况并不是不存在，比如我们给现有的方块外包一层`Padding`（`SingleChildRenderObjectElement`）：

```
  @override
  void initState() {
    super.initState();
    widgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulColorfulTile(key: Key("1"),)
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulColorfulTile(key: Key("2"),)
      ),
    ];
  }
```

这种情况下，交换后比较外层Padding不变，接着比较内层StatefulColorfulTile，因为key不相同导致颜色随机改变。因为两个方块位于不同子树，两者在逐层对比中用到的就是canUpdate方法返回false来更改。

而本例是方块的外层是Row（MultiChildRenderObjectElement），是对比两个List，存在不同。关键在于update时调用的RenderObjectElement.updateChildren方法。

```
  @protected
  List<Element> updateChildren(List<Element> oldChildren, List<Widget> newWidgets, { Set<Element> forgottenChildren }) {
      ...
    int newChildrenTop = 0;
    int oldChildrenTop = 0;
    int newChildrenBottom = newWidgets.length - 1;
    int oldChildrenBottom = oldChildren.length - 1;

    final List<Element> newChildren = oldChildren.length == newWidgets.length ?
        oldChildren : List<Element>(newWidgets.length);

    Element previousChild;

    // 从前往后依次对比，相同的更新Element，记录位置，直到不相等时跳出循环。
    while ((oldChildrenTop <= oldChildrenBottom) && 
        (newChildrenTop <= newChildrenBottom)) {
      final Element oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenTop]);
      final Widget newWidget = newWidgets[newChildrenTop];
      // 注意这里的canUpdate，本例中在没有添加key时返回true。
      // 因此直接执行updateChild，本循环结束返回newChildren。后面因条件不满足都在不执行。
      // 一旦添加key，这里返回false，不同之处就此开始。
      if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget))
        break;
      final Element newChild = updateChild(oldChild, newWidget, previousChild);
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
      oldChildrenTop += 1;
    }

    // 从后往前依次对比，记录位置，直到不相等时跳出循环。
    while ((oldChildrenTop <= oldChildrenBottom) && 
        (newChildrenTop <= newChildrenBottom)) {
      final Element oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenBottom]);
      final Widget newWidget = newWidgets[newChildrenBottom];
      if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget))
        break;
      oldChildrenBottom -= 1;
      newChildrenBottom -= 1;
    }
    // 至此，就可以得到新旧List中不同Weiget的范围。
    final bool haveOldChildren = oldChildrenTop <= oldChildrenBottom;
    Map<Key, Element> oldKeyedChildren;
    // 如果存在中间范围，扫描旧children，获取所有的key与Element保存至oldKeyedChildren。
    if (haveOldChildren) {
      oldKeyedChildren = <Key, Element>{};
      while (oldChildrenTop <= oldChildrenBottom) {
        final Element oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenTop]);
        if (oldChild != null) {
          if (oldChild.widget.key != null)
            oldKeyedChildren[oldChild.widget.key] = oldChild;
          else
              // 没有key就移除对应的Element
            deactivateChild(oldChild);
        }
        oldChildrenTop += 1;
      }
    }
    // 更新中间不同的部分
    while (newChildrenTop <= newChildrenBottom) {
      Element oldChild;
      final Widget newWidget = newWidgets[newChildrenTop];
      if (haveOldChildren) {
        final Key key = newWidget.key;
        if (key != null) {
          // key不为null，通过key获取对应的旧Element
          oldChild = oldKeyedChildren[key];
          if (oldChild != null) {
            if (Widget.canUpdate(oldChild.widget, newWidget)) {
              oldKeyedChildren.remove(key);
            } else {
              oldChild = null;
            }
          }
        }
      }
      // 本例中这里的oldChild.widget与newWidget hashCode相同，在updateChild中成功被复用。
      final Element newChild = updateChild(oldChild, newWidget, previousChild);
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
    }
    
    // 重置
    newChildrenBottom = newWidgets.length - 1;
    oldChildrenBottom = oldChildren.length - 1;

    // 将后面相同的Element更新后添加到newChildren，至此形成新的完整的children。
    while ((oldChildrenTop <= oldChildrenBottom) && 
        (newChildrenTop <= newChildrenBottom)) {
      final Element oldChild = oldChildren[oldChildrenTop];
      final Widget newWidget = newWidgets[newChildrenTop];
      final Element newChild = updateChild(oldChild, newWidget, previousChild);
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
      oldChildrenTop += 1;
    }

    // 清除旧列表中多余的Element
    if (haveOldChildren && oldKeyedChildren.isNotEmpty) {
      for (Element oldChild in oldKeyedChildren.values) {
        if (forgottenChildren == null || !forgottenChildren.contains(oldChild))
          deactivateChild(oldChild);
      }
    }

    return newChildren;
  }
```
这个方法有点复杂，详细的执行流程我在代码中添加了注释。看完这个diff算法，只能说一句：妙啊！！

到此也就解释了我们一开始提出的问题。不知道你对这不起眼的key是不是有了更深的认识。通过上面的例子可以总结以下三点：
- 一般情况下不设置key也会默认复用Element。
- 对于更改同一父级下Widget（尤其是runtimeType不同的Widget）的顺序或是增删，使用key可以更好的复用Element，提升性能。
- StatefulWidget使用key，可以在发生变化时保持state。不至于发生本例中“身体交换”的bug。

### Key的种类

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5fe564c95fd9402088caf79fd55f7b90~tplv-k3u1fbpfcp-watermark.image?)
### LocalKey
LocalKey 继承自 Key，在同一父级的Element之间必须是唯一的。（当然了，你要是写成不唯一也行，不过后果自负哈。。。）

我们基本不直接使用LocalKey ，而是使用的它的子类：

#### ValueKey

我们上面使用到的Key，其实就是ValueKey<String>。它主要是使用特定类型的值来做标识的，像是“值引用”，比如int、String等类型。我们看它源码中的 ==操作符方法：

```
class ValueKey<T> extends LocalKey {
  const ValueKey(this.value);
  
  final T value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final ValueKey<T> typedOther = other;
    return value == typedOther.value; // <---
  }
  ...
}
```

#### ObjectKey
有“值引用”，就有“对象引用”。主要还是`==`操作符方法

```
class ObjectKey extends LocalKey {
  const ObjectKey(this.value);

  final Object value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType)
      return false;
    final ObjectKey typedOther = other;
    return identical(value, typedOther.value); // <---
  }
  ...
}
```
#### UniqueKey
会生成一个独一无二的key值。

```
class UniqueKey extends LocalKey {
  UniqueKey();

  @override
  String toString() => '[#${shortHash(this)}]';
}

String shortHash(Object object) {
  return object.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0');
}
```
PageStorageKey

用于保存和还原比Widget生命周期更长的值。比如用于保存滚动的偏移量。每次滚动完成时，PageStorage会保存其滚动偏移量。 这样在重新创建Widget时可以恢复之前的滚动位置。类似的，在ExpansionTile中用于保存展开与闭合的状态。

具体的实现原理也很简单，看看PageStorage的源码就清楚了，这里就不展开了。

### GlobalKey
GlobalKey 也继承自 Key，在整个应用程序中必须是唯一的。GlobalKey源码有点长，我就不全部贴过来了。

```
@optionalTypeArgs
abstract class GlobalKey<T extends State<StatefulWidget>> extends Key {
  factory GlobalKey({ String debugLabel }) => LabeledGlobalKey<T>(debugLabel);

  const GlobalKey.constructor() : super.empty();

  static final Map<GlobalKey, Element> _registry = <GlobalKey, Element>{};
  // 在`Element的 `mount`中注册GlobalKey。
  void _register(Element element) {
    _registry[this] = element;
  }
  // 在`Element的 `unmount`中注销GlobalKey。
  void _unregister(Element element) {
    if (_registry[this] == element)
      _registry.remove(this);
  }

  Element get _currentElement => _registry[this];

  BuildContext get currentContext => _currentElement;
  
  Widget get currentWidget => _currentElement?.widget;

  T get currentState {
    final Element element = _currentElement;
    if (element is StatefulElement) {
      final StatefulElement statefulElement = element;
      final State state = statefulElement.state;
      if (state is T)
        return state;
    }
    return null;
  }
  ...
}
```
它的内部存在一个Map<GlobalKey, Element>的静态Map，通过调用_register、_unregister方法来添加和删除Element。同时它的内部还持有当前的Element、Widget甚至State。可以看到 GlobalKey是非常昂贵的，没有特别的复用需求，不建议使用它。

怎么复用呢？GlobalKey在上面inflateWidget的源码中出现过一次。当发现key是GlobalKey时，使用_retakeInactiveElement方法复用Element。

```
  Element _retakeInactiveElement(GlobalKey key, Widget newWidget) {
    final Element element = key._currentElement;
    if (element == null)
      return null;
    if (!Widget.canUpdate(element.widget, newWidget))
      return null;
    final Element parent = element._parent;
    if (parent != null) {
      parent.forgetChild(element);
      parent.deactivateChild(element);
    }
    owner._inactiveElements.remove(element);
    return element;
  }
```
如果获取到了`Element`，那么就从旧的节点上移除并返回。否则将在`inflateWidget`重新创建新的`Element`。

#### GlobalKey使用
- 首先就是上面提到的使用相同的GlobalKey来实现复用。
- 利用GlobalKey持有的BuildContext。比如常见的使用就是获取Widget的宽高信息，通过BuildContext可以在其中获取RenderObject或Size，从而拿到宽高信息。这里就不贴代码了，有需要可以看此处示例。
- 利用GlobalKey持有的State，实现在外部调用StatefulWidget内部方法。比如常用GlobalKey<NavigatorState>来实现无Context跳转页面，在点击推送信息跳转指定页面就需要用到。

创建一个`GlobalKey<NavigatorState>`
```  
static GlobalKey<NavigatorState> navigatorKey = new GlobalKey();
```
添加至MaterialApp：

``` 
MaterialApp(
   navigatorKey: navigatorKey,
   ...
  );
```
然后就是调用push方法：

```
navigatorKey.currentState.push(MaterialPageRoute(
    builder: (BuildContext context) => MyPage(),
  ));
```
通过`GlobalKey`持有的`State`，就可以调用其中的方法、获取数据。

#### []()LabeledGlobalKey

它是一个带有标签的`GlobalKey`。 该标签仅用于调试，不用于比较。

#### []()GlobalObjectKey

同上`ObjectKey`。区别在于它是`GlobalKey`。
