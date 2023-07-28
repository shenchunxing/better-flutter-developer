### 为什么使用Flutter?
-   性能：实现了自绘引擎，保持不同端UI一致性，动画流畅性
-   生态：从Github上来看，目前Flutter活跃用户正在高速增长。从Stackoverflow上提问来看，Flutter社区现在已经很庞大。
-   技术支持：现在Google正在大力推广Flutter，Flutter的作者中很多人都是来自Chromium团队，并且github上活跃度很高。
-   开发效率：Flutter的热重载可帮助开发者快速地进行测试、构建UI、添加功能并更快地修复错误。在iOS和Android模拟器或真机上可以实现毫秒级热重载，并且不会丢失状态。

### Flutter怎么做到并发？
Flutter在执行UI渲染和逻辑处理时，是单线程的。这意味着在Flutter应用中，UI渲染和逻辑处理是在同一个线程上顺序执行的。

然而，Flutter提供了一些机制来实现异步和并发处理，以确保应用在处理复杂任务时能够保持响应性。以下是一些在Flutter中实现并发的方法：

Isolates（孤立体）：
Flutter中的Isolate是Dart语言中的一个重要特性，它可以实现并发执行。Isolate是独立的执行单元，每个Isolate都运行在自己的线程中，可以并行地执行任务，因此不会阻塞UI线程。这种效果已经类似并行执行了。Flutter 的单线程机制在一定程度上限制了对多核 CPU 的利用，但 Flutter 提供了 Isolate 作为多线程机制，以允许在后台执行任务并更好地利用多核 CPU 的性能。

异步/await：
在Dart中，可以使用异步/await机制来执行异步任务。通过使用async关键字标记一个函数为异步函数，然后在需要等待的地方使用await关键字，可以在执行异步任务时暂停当前函数的执行，然后等待异步任务完成后再继续执行。

Futures：
Flutter使用Futures来处理异步操作的结果。Future表示一个可能会在未来完成的操作，可以注册回调来处理其完成或错误情况。

compute函数：
Flutter提供了compute函数，它可以在后台Isolate中运行一个函数，避免在UI线程上执行耗时的计算。

事件循环（Event Loop）：
Flutter应用的事件循环机制确保了UI渲染和逻辑处理的异步执行。Flutter的事件循环机制使用Future和微任务队列来处理各种任务。

尽管Flutter本身在UI渲染和逻辑处理上是单线程的，但使用上述机制，可以实现异步和并发处理，从而确保应用在处理复杂任务时仍然能够保持流畅和响应性。


### 如何优化项目中的Flutter的性能的？
减少Widget重建：
避免不必要的Widget重建可以显著提高性能。使用const关键字创建静态不变的Widget，或者使用const构造函数来创建Widget，这样可以避免重复创建相同的Widget。

使用Keys：
在ListView或GridView等可滚动列表中，使用Key来标识每个列表项。这样可以帮助Flutter更好地识别和管理列表项的状态变化，避免不必要的重建。

异步加载：
在加载图片、网络请求等耗时操作时，使用异步加载来避免阻塞UI线程。可以使用FutureBuilder或StreamBuilder来处理异步数据加载。

避免过度绘制：
避免在绘制过程中进行不必要的操作，减少绘制的复杂性。尽量使用简单的UI元素和布局来减少绘制的工作量。

内存管理：
确保及时释放不再需要的资源，避免内存泄漏。关闭文件句柄、取消订阅事件、清理缓存等都是优化内存的重要步骤。

懒加载：
对于一些复杂的Widget或页面，可以采用懒加载的方式，在需要时再进行渲染和初始化，避免一次性加载过多内容。

性能分析：
使用Flutter DevTools等性能分析工具来监测应用的性能表现，找到性能瓶颈并进行优化。

更新依赖库版本：
确保使用最新版本的Flutter和相关依赖库，以获得性能改进和Bug修复。

待整理文章：
[超级全面的Flutter性能优化实践](https://juejin.cn/post/7145730792948252686?searchId=2023072810021848AD564BE2C58A87978C#heading-9)
[淘特 Flutter 流畅度优化实践](https://juejin.cn/post/7046305749097512997?searchId=20230728100804392A9B8AC091F08ABF5A)

### Flutter页面出现内存问题，怎么查找原因？

使用Flutter DevTools：Flutter DevTools是一个强大的工具，可用于分析和调试Flutter应用程序。您可以使用DevTools来检查内存使用情况、查看内存快照、查找内存泄漏和其他性能问题。在浏览器中打开DevTools并连接到您的Flutter应用程序，然后选择"Memory"选项卡来开始检查内存使用情况。

    分析内存快照：在DevTools中，您可以捕获应用程序的内存快照，以便查看当前内存中的对象和引用。通过查看快照，您可以识别哪些对象没有被正确释放或哪些对象占用了大量内存。

    查找内存泄漏：使用DevTools的内存视图，检查是否有任何潜在的内存泄漏。确保在页面切换或不再使用时，所有不再需要的资源和对象都被正确释放。

优化图片和资源：图片和其他资源可能会占用大量内存。使用合适的图片格式和压缩来降低内存消耗。

避免频繁的Widget重建：在Flutter中，Widget的重建可能会导致额外的内存消耗。优化您的Widget结构，避免不必要的重建，尤其是在频繁刷新的地方。

使用ListView.builder和GridView.builder：当处理大量数据时，使用ListView.builder和GridView.builder等“懒加载”Widget，以避免一次性加载大量项目到内存中。

使用辅助工具：除了Flutter DevTools，还可以使用其他第三方工具和插件来检测和优化内存问题。例如，flutter_memory_monitor插件可以帮助您在应用程序运行时监控内存使用情况。

更新Flutter和依赖库：确保您正在使用最新版本的Flutter和相关依赖库，以便获得已解决的问题和性能改进。

测试不同设备和配置：有时，内存问题可能在某些设备或配置上更为明显。尝试在不同的设备和配置上测试您的应用程序，以确保性能和内存使用情况在各种情况下都能得到处理。

使用Profiling和Debug模式：在调试内存问题时，尝试在Debug模式下运行应用程序。在Debug模式下，性能可能会受到影响，但您可以更容易地发现问题并调试。

通过以上方法，您应该能够查找并解决Flutter页面的内存问题。记得持续测试和优化您的应用程序，以确保它在各种情况下都能够运行顺畅。

### Flutter和RN的对比
**1. 环境搭建**：

React Native:
需要 npm 、node 、react-native-cli 等配置

Flutter:需要 flutter sdk 和 Android Studio / VSCode 上的 Dart 与 Flutter 插件。

**2. 实现原理**：

React Native:

通过写 JS 代码配置页面布局，然后 React Native 最终会解析渲染成原生控件，如 标签对应 ViewGroup/UIView ， 标签对应 ScrollView/UIScrollView ，![]() 标签对应 ImageView/UIImageView 等。

Flutter:

Flutter中绝大部分的 Widget 都与平台无关， 开发者基于 Framework 开发 App ，而 Framework 运行在 Engine 之上，由 Engine 进行适配和跨平台支持。这个跨平台的支持过程，其实就是将 Flutter UI 中的 Widget “数据化” ，然后通过 Engine 上的 Skia 直接绘制到屏幕上

**3. 语言**：
都支持通过 var 定义变量，支持 async/await 语法糖，支持 Promise(Future) 等链式异步处理

**JS** 是动态语言，而 **Dart** 是伪动态语言的强类型语言。动态语言和非动态语言都有各种的优缺点，比如 JS 开发便捷度明显会高于 Dart ，而 Dart 在类型安全和重构代码等方面又会比 JS 更稳健。

**4. 图示** ![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/819958f7cf1e4b118e4d57510eb1fffc~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)


### Dart 是不是单线程模型？是如何运行的？
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fdbb8aadca104c41b1ad5e31a58e496d~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)
引用《Flutter中文网》里的话：

> Dart 在单线程中是以消息循环机制来运行的，其中包含两个任务队列，一个是“微任务队列” **microtask queue**，另一个叫做“事件队列” **event queue**。
>
> 入口函数 main() 执行完后，消息循环机制便启动了。首先会按照先进先出的顺序逐个执行微任务队列中的任务，当所有微任务队列执行完后便开始执行事件队列中的任务，事件任务执行完毕后再去执行微任务，如此循环往复，生生不息。

### Dart 多任务如何并行的？
Dart 当中提供了一个 **类似于新线程，但是不共享内存的独立运行的 worker - isolate**。

那他们是如何交互的？

这里引用 flutter入门之dart中的并发编程、异步和事件驱动详解 中的一部分答案：
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5538663c63164192a1e833e384927110~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)
在dart中，一个Isolate对象其实就是一个isolate执行环境的引用，一般来说我们都是通过当前的isolate去控制其他的isolate完成彼此之间的交互，而当我们想要创建一个新的Isolate可以使用**Isolate.spawn**方法获取返回的一个新的isolate对象，两个isolate之间使用SendPort相互发送消息，而isolate中也存在了一个与之对应的ReceivePort接受消息用来处理，但是我们需要注意的是，ReceivePort和SendPort在每个isolate都有一对，只有同一个isolate中的ReceivePort才能接受到当前类的SendPort发送的消息并且处理。

### Flutter的异步机制 (Future、Stream有什么区别？)
在Flutter中，Future和Stream都是用于处理异步操作的重要概念，但它们在功能和使用方式上有一些区别。

1.  Future（未来）：

    -   Future表示一个可能会在未来完成的异步操作，并且在操作完成后会返回一个结果或错误。
    -   Future可以理解为一个容器，它包含了异步操作的结果。在异步操作完成之前，Future处于"未完成"状态；一旦异步操作完成，Future将变为"完成"状态。
    -   Future通常用于执行一次性的异步操作，例如网络请求、文件读写等。

    示例代码：
    ```
    Future<int> fetchData() {
      return Future.delayed(Duration(seconds: 1), () => 42);
    }
    void main() {
      fetchData().then((value) {
        print("Result: $value"); // 输出：Result: 42
      });
    }
    ```
1.  Stream（流）：
    -   Stream表示一系列可能会在未来产生的异步事件序列，并且允许监听和响应这些事件。
    -   Stream是一个数据流，可以有多个事件产生，并且可以持续触发多次。每当有新事件产生时，Stream会将事件发送给订阅（监听）它的监听器。
    -   Stream通常用于处理实时数据流，例如用户输入、传感器数据等。
    示例代码：
    ```
    Stream<int> countDownStream() async* {
      for (int i = 5; i >= 1; i--) {
        await Future.delayed(Duration(seconds: 1));
        yield i;
      }
    }

    void main() {
      countDownStream().listen((value) {
        print(value); // 输出：5 4 3 2 1
      });
    }
    ```

主要区别：
-   Future表示一个单一的异步操作，并返回一个结果或错误。一旦Future的异步操作完成，它的任务就结束了。
-   Stream表示一个异步事件序列，可以多次触发事件，并且在任何时候都可能有新的事件产生。它可以持续监听事件的产生。

### StatefulWidget 的生命周期？
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c2fe670c6e954b4db4b02e478a8b5128~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)
StatefulWidget 的生命周期方法及其调用顺序：

1.  createState():
    -   当 StatefulWidget 被创建时，会调用 createState() 方法，它返回一个 State 对象。
    -   通常在这个方法中进行初始化工作，比如获取数据、设置初始状态等。
    -   
1.  initState():
    -   在 createState() 返回 State 对象后，会立即调用 initState() 方法。
    -   initState() 在 StatefulWidget 生命周期中只会被调用一次。
    -   这个方法通常用于订阅流或初始化一些只需要执行一次的操作。

1.  didChangeDependencies():
    -   在 initState() 之后，会调用 didChangeDependencies() 方法。
    -   在该方法中可以处理依赖关系的变化，例如获取来自父级 Widget 的数据，并根据数据的变化进行相应操作。

1.  build():
    -   在完成 initState() 和 didChangeDependencies() 后，会调用 build() 方法。
    -   build() 方法用于构建 Widget 树，并返回当前的 Widget。
    -   每当需要更新 UI 时（比如状态发生变化），都会调用 build() 方法。

1.  didUpdateWidget():
    -   在调用 build() 后，如果 Widget 树中有其他父级 Widget 重建，就会调用 didUpdateWidget() 方法。
    -   在这个方法中，你可以对比前后的 Widget 属性，并作出相应的处理，例如更新状态。

1.  setState():
    -   当需要更新 StatefulWidget 的状态时，调用 setState() 方法。
    -   在 setState() 方法中，你可以改变 StatefulWidget 的状态，然后 Flutter 会重新调用 build() 方法来更新 UI。

1.  deactivate():
    -   当 StatefulWidget 被移出渲染树时，会调用 deactivate() 方法。
    -   之后，如果 StatefulWidget 被重新插入渲染树，会重新调用 build() 方法。

1.  dispose():
    -   当 StatefulWidget 被永久移除时，会调用 dispose() 方法。
    -   在这个方法中，可以执行一些资源释放的操作，比如取消订阅流、关闭定时器等。

需要注意的是，StatefulWidget 的生命周期方法在 State 对象中定义，而且生命周期方法的调用顺序是固定的，遵循上述顺序。根据不同的场景和需求，可以在合适的生命周期方法中执行相应的操作，以确保应用程序的状态和 UI 的正确更新。

### Flutter是如何做到一套Dart代码可以编译运行在Android和iOS平台的？所以说具体的原理?
-   Skia绘制，实现跨平台应用层渲染一致性
-   Method Channel 机制

为了解决调用原生系统底层能力以及相关代码库复用问题，Flutter 为开发者提供了一个轻量级的解决方案，即逻辑层的方法通道（Method Channel）机制。基于方法通道，我们可以将原生代码所拥有的能力，以接口形式暴露给 Dart，从而实现 Dart 代码与原生代码的交互，就像调用了一个普通的 Dart API 一样。

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b8435483710f4fb0b07d08856cfd4d3c~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

**Flutter定义了三种不同类型的Channel**

-   BasicMessageChannel：用于传递字符串和半结构化的信息。
-   MethodChannel：用于传递方法调用（method invocation）。
-   EventChannel: 用于数据流（event streams）的通信。

**注意**

Method Channel 是非线程安全的。原生代码在处理方法调用请求时，如果涉及到异步或非主线程切换，需要确保回调过程是在原生系统的 UI 线程（也就是 Android 和 iOS 的主线程）中执行的，否则应用可能会出现奇怪的 Bug，甚至是 Crash。

### 什么是 Widgets、RenderObjects 和 Elements？
在Flutter中，Widgets、RenderObjects和Elements是构建用户界面的三个核心概念。它们相互关联，并共同构成了Flutter UI的基础。下面对它们进行简要解释：

1.  Widgets（小部件）：
    -   Widgets是Flutter中构建用户界面的基本单元。它们是不可变的，即创建后不能直接修改。如果需要更改UI，需要创建一个新的Widget。
    -   Widgets可以是有状态的（Stateful Widgets）或无状态的（Stateless Widgets）。
    -   Stateless Widgets表示没有状态变化的静态UI元素，它们在被创建后不会改变。
    -   Stateful Widgets表示具有可变状态的UI元素，它们在状态发生变化时会重建自身，并且可以通过setState()方法来触发UI的更新。

1.  RenderObjects（渲染对象）：
    -   RenderObjects是Flutter用于实际绘制和布局的底层对象。它们表示界面上的可视元素，并定义了它们如何渲染和排列。
    -   Widgets只是一个描述性配置，而RenderObjects是执行实际绘制和布局的工作。
    -   RenderObjects是高度优化的，负责处理各种渲染操作，如绘制、布局、点击检测等。

1.  Elements（元素）：
    -   Elements是Widgets和RenderObjects之间的桥梁。每个Widget都与一个Element相对应。
    -   Element是Widgets和RenderObjects的中间层，它负责将Widget树转换为RenderObject树，并与渲染引擎进行交互。
    -   Element维护了与Widget和RenderObject相关联的状态信息，并在需要时重新构建UI。

关系：
-   Widgets用于描述UI的层次结构和配置，它们是构建UI的基本元素。
-   Elements负责管理Widgets，并与RenderObjects进行通信，实现Widgets到RenderObjects的转换。
-   RenderObjects是实际进行渲染和布局的对象，它们处理最终的绘制和渲染操作。

整个过程可以概括为：Widgets描述UI的结构，Elements管理Widgets，并负责生成RenderObjects，最后RenderObjects实现实际的绘制和布局。通过这种组织结构，Flutter能够高效地构建、绘制和更新复杂的用户界面，并提供优秀的性能。

### Flutter不具备反射，如果要使用反射，你应该如何使用？说一下大概的思路?
在Flutter中，由于Dart语言本身不直接支持反射，因此Flutter框架没有内置的反射功能。反射是一种在运行时动态地访问、检查和修改对象的能力，它允许我们在不知道具体类型的情况下，对对象进行操作。

虽然Flutter本身不支持反射，但是仍然可以通过其他方式来模拟实现类似的功能。以下是一些可能的实现思路：

1.  手动维护映射表：  
    可以手动维护一个映射表，将类名或标识符与具体类型关联起来。然后在需要使用反射的地方，通过查找映射表来获取实际类型，并进行相应的操作。
1.  使用第三方库：  
    Dart有一些第三方库，例如 `reflectable` 和 `mirrors`，它们提供了一些反射功能。这些库可能并不是完全符合Flutter的设计理念，但在一些特殊场景下可能会有用。
1.  代码生成工具：  
    可以使用Dart的代码生成工具，根据特定的规则和配置，生成代码来实现类似于反射的功能。这种方法需要预先定义代码生成规则，然后在编译时生成对应的代码。

需要注意的是，虽然可以通过上述方法模拟实现一些反射功能，但这些方法往往会带来额外的复杂性和性能开销。在Flutter中，通常推荐避免使用反射，尽量采用更加静态和类型安全的方式来构建应用程序，这样可以提高应用程序的性能和可维护性。

### 如何让Flutter 编译出来的APP的包大小尽可能的变小?
减小Flutter编译出来的APP的包大小是一个重要的优化目标，可以采取以下一些方法来尽可能地减小包大小：

1.  使用代码混淆和压缩：  
    使用代码混淆（例如R8或ProGuard对Android，Dart编译器对iOS）可以将代码中的变量和类名进行混淆，从而减小包大小。同时，使用代码压缩可以删除未使用的代码，进一步减小包大小。
1.  移除未使用的资源：  
    审查并移除未使用的资源文件，如图片、字体、音频文件等。这可以通过使用Flutter的代码静态分析工具来实现，如`flutter analyze`命令。
1.  使用Asset Bundle的精细化配置：  
    将资源文件（如图片）根据不同的屏幕密度进行分组，并在Asset Bundle中配置只加载所需的分组。这样可以避免不必要的资源加载，减小包大小。
1.  优化图像和音频：  
    使用适当的图像压缩和音频压缩工具，减小图像和音频文件的大小。同时，使用WebP或其他高效的图像格式，可以显著减小图像资源的大小。
1.  延迟加载和懒加载：  
    将不常用或初始化较慢的组件延迟加载或懒加载，使得应用程序启动速度更快，并减小初始包大小。
1.  使用动态链接：  
    Flutter默认使用静态链接（AOT编译），这会导致较大的包大小。考虑使用动态链接（JIT编译）来减小包大小，但请注意动态链接可能会影响应用程序性能。
1.  优化依赖：  
    审查项目依赖库，只保留必要的依赖，避免引入不必要的代码和资源。
1.  分析APK文件：  
    使用工具分析APK文件，找出包含在包中的文件，并评估它们的大小和使用情况，以便进一步优化。
1.  使用Flutter提供的优化工具：  
    Flutter提供了一些优化工具，如`flutter build`命令的各种参数和标志，可以帮助优化包大小。

通过综合运用上述优化策略，可以显著减小Flutter编译出来的APP的包大小，提升应用程序的性能和用户体验。然而，需要注意的是，优化的过程可能需要权衡一些因素，如性能和功能需求，以找到最佳的优化方案。

### 谈谈Flutter的内存回收管理机制，以及你平时是怎么处理内存的？内存泄漏和内存溢出你是怎么解决的?
Flutter的内存回收管理机制主要依赖于Dart语言的垃圾回收机制。Dart使用自动垃圾回收（Garbage Collection，GC）来管理内存，它通过监测不再使用的对象，并回收这些对象所占用的内存空间，以确保内存的有效利用。Flutter应用程序在运行过程中，Dart的垃圾回收器会自动在合适的时机进行垃圾回收。

平时处理内存方面的一些方法包括：

1.  使用Dart的内存分析工具：  
    Flutter提供了一些内存分析工具，如`flutter analyze`和`flutter doctor`，用于检查和诊断内存问题。可以通过这些工具来查找内存泄漏和内存溢出的问题。
1.  避免不必要的对象创建：  
    在代码编写过程中，尽量避免频繁创建大量的临时对象，尤其是在循环中。可以考虑重用对象或使用对象池等技术来减少对象的创建和销毁。
1.  关闭不需要的资源：  
    在不再需要的时候，及时关闭文件、数据库连接、网络连接等资源，避免资源泄漏。
1.  使用弱引用：  
    对于可能导致内存泄漏的对象引用，可以使用弱引用（Weak References）来避免强引用循环导致的问题。
1.  使用Async/Await和Stream：  
    在处理异步任务时，合理使用Async/Await和Stream来避免内存泄漏和过度占用内存。
1.  分析内存泄漏和溢出问题：  
    如果发现内存泄漏或溢出问题，可以使用内存分析工具来查找问题的根源，并进行优化和修复。

解决内存泄漏和内存溢出问题的一些常见方法包括：

1.  清理不再使用的引用：  
    确保及时清理不再使用的对象引用，防止对象无法被垃圾回收器回收。
1.  使用WeakReference来避免强引用循环：  
    在一些场景下，可能会产生强引用循环，使用WeakReference可以解决这个问题。
1.  关闭资源：  
    在不再使用的时候，及时关闭文件、数据库连接、网络连接等资源，避免资源泄漏。
1.  避免使用过大的内存缓存：  
    对于大量的图片、数据等缓存，可以使用LRU（最近最少使用）等算法来控制缓存大小，避免内存溢出。
1.  使用Dart的内存分析工具：  
    使用Dart的内存分析工具来检查内存泄漏和内存溢出问题，并进行优化和修复。

综合采取上述措施，可以有效地管理Flutter应用程序的内存，避免内存泄漏和内存溢出问题，提高应用程序的性能和稳定性。

详细见：[Dart内存管理](http://www.helloted.com/flutter/2019/05/13/DartRuntime/)

### Flutter的Hot Reload和Hot Restart是怎么实现的？
**区别**

修改了状态相关的代码则需要hot restart，否则只需要 hot reload即可

**Hot Reload原理**

Flutter 提供的两种编译模式中，**AOT** 是静态编译，即编译成设备可直接执行的二进制码；而 **JIT** 则是动态编译，即将 Dart 代码编译成中间代码（Script Snapshot），在运行时设备需要 Dart VM 解释执行。

而热重载之所以只能在 Debug 模式下使用，是因为 Debug 模式下，Flutter 采用的是 JIT 动态编译（而 Release 模式下采用的是 AOT 静态编译）。JIT 编译器将 Dart 代码编译成可以运行在 Dart VM 上的 Dart Kernel，而 Dart Kernel 是可以动态更新的，这就实现了代码的实时更新功能，

总体来说，完成热重载的可以分为扫描工程改动、增量编译、推送更新、代码合并、Widget 重建 5 个步骤。

1.  工程改动。热重载模块会逐一扫描工程中的文件，检查是否有新增、删除或者改动，直到找到在上次编译之后，发生变化的 Dart 代码。
1.  增量编译。热重载模块会将发生变化的 Dart 代码，通过编译转化为增量的 Dart Kernel 文件。
1.  推送更新。热重载模块将增量的 Dart Kernel 文件通过 HTTP 端口，发送给正在移动设备上运行的 Dart VM。
1.  代码合并。Dart VM 会将收到的增量 Dart Kernel 文件，与原有的 Dart Kernel 文件进行合并，然后重新加载新的Dart Kernel 文件。
1.  Widget 重建。在确认 Dart VM 资源加载成功后，Flutter 会将其 UI 线程重置，通知 Flutter Framework 重建 Widget。

**不支持 Hot Reload 的场景**

-   代码出现编译错误；
-   Widget 状态无法兼容；
-   全局变量和静态属性的更改；
-   main 方法里的更改；
-   initState 方法里的更改；
-   枚举和泛类型更改

### Flutter 渲染机制？
Flutter的渲染机制是其能够实现高性能和流畅用户界面的核心。Flutter使用自己的渲染引擎来绘制UI组件，该渲染引擎被称为Skia。以下是Flutter的渲染机制的基本原理：

1.  组件树（Widget Tree）：  
    Flutter应用程序的用户界面由组件树构成。每个组件（Widget）都是一个声明式的UI元素，它描述了在屏幕上如何渲染一个部分。组件树是不可变的，当应用程序的状态发生变化时，Flutter会通过构建新的组件树来表示新的UI。
1.  Element树（Element Tree）：  
    在组件树构建后，Flutter将组件树转换为Element树。Element是组件的运行时表示，它与组件一一对应。Element维护了与组件相关联的状态信息，并负责管理与渲染和布局相关的任务。
1.  渲染树（Render Object Tree）：  
    在Element树构建后，Flutter将Element树转换为渲染树。渲染树由RenderObject对象构成，它是渲染引擎中的基本单位，用于描述渲染和布局的信息。每个RenderObject与一个Element相对应，并负责绘制和排列对应的UI部分。
1.  绘制和布局：  
    当渲染树构建完成后，Flutter的渲染引擎将会对渲染树进行布局（Layout）和绘制（Paint）。布局阶段会计算每个RenderObject的位置和大小，确定它们在屏幕上的布局。绘制阶段会根据布局信息将RenderObject绘制到屏幕上，形成最终的UI界面。
1.  增量绘制和GPU加速：  
    Flutter的渲染引擎使用增量绘制（Incremental Painting）技术，只重新绘制发生变化的部分，从而减少不必要的绘制操作，提高性能。同时，Flutter还利用GPU加速，通过OpenGL或Vulkan等底层图形库，将渲染操作交给GPU来加速绘制过程。
1.  热重载和重启：  
    Flutter的热重载（Hot Reload）和热重启（Hot Restart）功能允许开发者在开发过程中快速查看代码更改的效果。热重载可以在保持应用程序状态的情况下重新加载代码，而热重启会重置整个应用程序的状态。这样，开发者可以实时地查看代码更改后的UI效果。
    
### Flutter架构   
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7da3176245374660b467a5f83727724f~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp )
由上图可知，Flutter框架自下而上分为Embedder、Engine和Framework三层。其中，Embedder是操作系统适配层，实现了渲染 Surface设置，线程设置，以及平台插件等平台相关特性的适配；Engine层负责图形绘制、文字排版和提供Dart运行时，Engine层具有独立虚拟机，正是由于它的存在，Flutter程序才能运行在不同的平台上，实现跨平台运行；Framework层则是使用Dart编写的一套基础视图库，包含了动画、图形绘制和手势识别等功能，是使用频率最高的一层。

##### 介绍下FFlutter的FrameWork层和Engine层，以及它们的作用

Flutter的FrameWork层是用Drat编写的框架（SDK），它实现了一套基础库，包含Material（Android风格UI）和Cupertino（iOS风格）的UI界面，下面是通用的Widgets（组件），之后是一些动画、绘制、渲染、手势库等。这个纯 Dart实现的 SDK被封装为了一个叫作 dart:ui的 Dart库。我们在使用 Flutter写 App的时候，直接导入这个库即可使用组件等功能。

Flutter的Engine层是Skia 2D的绘图引擎库，其前身是一个向量绘图软件，Chrome和 Android均采用 Skia作为绘图引擎。Skia提供了非常友好的 API，并且在图形转换、文字渲染、位图渲染方面都提供了友好、高效的表现。Skia是跨平台的，所以可以被嵌入到 Flutter的 iOS SDK中，而不用去研究 iOS闭源的 Core Graphics / Core Animation。Android自带了 Skia，所以 Flutter Android SDK要比 iOS SDK小很多。

### main入口函数会被调用几次？
[main入口函数会被调用几次](https://juejin.cn/post/6887559803544010765?searchId=20230720190952A3651A44650B0B3C085F)

### Flutter 启动过程？
1.  启动应用：当用户点击应用图标或通过其他方式打开Flutter应用时，操作系统会启动应用。
1.  启动入口：应用启动后，会执行`main()`函数作为入口点。在`main()`函数中，通常会运行`runApp()`方法，用于加载应用的根Widget并启动Flutter应用的运行循环。
1.  加载根Widget：`runApp()`方法会将根Widget加载到Flutter引擎中。根Widget是应用UI的起点，它通常是一个`MaterialApp`或`CupertinoApp`，用于设置应用的主题、路由等信息。
1.  初始化：Flutter引擎开始初始化，包括创建渲染树、布局、绘制等操作。Flutter应用的UI是通过渲染树来描述的，Flutter引擎会根据Widget树构建渲染树。
1.  热重载（可选）：在开发过程中，开发者可以通过热重载（Hot Reload）功能实时更新应用的代码，无需重启应用，从而加快开发速度。
1.  绘制UI：Flutter引擎将渲染树转换为图形，并将UI显示在设备屏幕上。Flutter使用Skia图形引擎来实现绘制，可以直接渲染到设备屏幕上，无需使用原生控件。
1.  运行循环：一旦应用启动并显示了UI，Flutter引擎会进入运行循环。在运行循环中，Flutter会监听用户输入事件、执行动画、处理布局变化等操作，以保持应用的响应性能。
1.  处理事件：当用户与应用交互时，如点击按钮、滑动屏幕等，Flutter会处理这些事件并根据Widget树中的变化来更新渲染树和UI。
1.  退出应用：当用户关闭应用或操作系统终止应用时，Flutter会执行相应的清理操作，并退出应用。

总结：Flutter启动过程主要包括加载根Widget、初始化Flutter引擎、绘制UI以及进入运行循环。Flutter的热重载功能可以帮助开发者快速迭代应用的UI和逻辑，提高开发效率。同时，Flutter的独立渲染机制使得应用可以直接绘制UI，无需依赖原生控件，从而实现跨平台的移动应用开发。

### Flutter 编译流程？
Flutter 的编译流程可以简要概括为以下几个主要步骤：

1.  Dart 代码编译：Flutter 使用 Dart 语言编写应用程序逻辑。在编译流程的第一步，Dart 代码将被编译成中间代码（bytecode）。这个过程可以使用 Dart 编译器（dart2js）将 Dart 代码转换为 JavaScript 代码，或者使用 Dart AOT（Ahead-Of-Time）编译器（dart）生成本地机器代码。
1.  Widget 构建：Flutter 应用的 UI 是通过组合各种 Widget 构建的。在 Widget 构建阶段，Flutter 引擎会根据 Widget 树的描述，逐级构建渲染树。Widget 树描述了应用的界面结构，而渲染树则是具体的绘制描述，用于展示在设备屏幕上。
1.  Skia 图形渲染：Flutter 使用 Google 的 Skia 图形库来执行绘制操作。Skia 是一个跨平台的图形库，用于绘制 2D 图形。Flutter 引擎会将渲染树转换为 Skia 操作，并在屏幕上绘制出应用的 UI。
1.  GPU 加速：Flutter 通过使用 GPU 加速来提高应用的性能。Flutter 在支持 GPU 加速的设备上，会将绘制操作交给 GPU 来执行，从而加快渲染速度并提升用户体验。
1.  平台特定绑定：Flutter 提供了一个统一的跨平台框架，但在特定平台上仍然需要与原生操作系统进行交互。Flutter 引擎使用平台特定绑定（Platform Channels）来与底层操作系统进行通信，从而实现对原生功能的调用。
1.  打包和部署：完成编译后，Flutter 应用的代码可以进行打包和部署。Flutter 支持将应用打包成 Android 和 iOS 的原生应用包（APK 和 IPA），也可以打包成 Web 应用或桌面应用。

总结：Flutter 的编译流程包括 Dart 代码编译、Widget 构建、Skia 图形渲染、GPU 加速以及平台特定绑定。这些步骤共同将 Flutter 应用转换为可以在不同平台上运行的可执行文件，并实现了跨平台的移动应用开发。

### Flutter 图片加载过程？
[Flutter 图片加载过程](https://juejin.cn/post/6844903817918545928?searchId=2023072115262304465D22831B65B5736C)
