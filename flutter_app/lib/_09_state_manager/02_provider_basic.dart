import 'package:flutter/material.dart';
import 'package:flutter_app/_09_state_manager/01_inheritedWidget.dart';
import 'package:flutter_app/_09_state_manager/viewmodel/counter_viewmodel.dart';
import 'package:provider/provider.dart';

/**
 * 1.创建自己需要共享的数据
 * 2.在应用程序的顶层ChangeNotifierProvider
 * 3.在其它位置使用共享的数据
 *  > Provider.of: 当Provider中的数据发生改变时, Provider.of所在的Widget整个build方法都会重新构建
 *  > Consumer(相对推荐): 当Provider中的数据发生改变时, 执行重新执行Consumer的builder
 *  > Selector: 1.selector方法(作用,对原有的数据进行转换) 2.shouldRebuild(作用,要不要重新构建)
 */
void main() {
  runApp(
    // 2.在应用程序的顶层ChangeNotifierProvider
    ChangeNotifierProvider(create: (ctx) => HYCounterViewModel(),child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('列表测试'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HYShowData01(),
            HYShowData02()
          ],
        ),
      ),

      //Selector: 需要传入2个泛型参数。1.selector方法(作用,对原有的数据进行转换) 2.shouldRebuild(作用,要不要重新构建)
      floatingActionButton: Selector<HYCounterViewModel,HYCounterViewModel>(
        selector: (ctx , counterVM) => counterVM,
        shouldRebuild: (prev , next) => false,
        builder: (ctx , counterVM,child) {
          print("floatingActionButton build方法被执行");
          return FloatingActionButton(child: child,onPressed: () {
            counterVM.counter += 1;
          });
        },
      ),
    );
  }
}

class HYShowData01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3.在其它位置使用共享的数据
    int counter = Provider.of<HYCounterViewModel>(context).counter;

    print("data01的build方法");

    return Container(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Text("当前计数: $counter", style: TextStyle(fontSize: 30),),
        ],
      ),
    );
  }
}

class HYShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("data02的build方法");

    return Container(
      color: Colors.red,
      child: Consumer<HYCounterViewModel>( //4.Consumer里面可以传一个参数，Consumer2可以传2个参数
        builder: (ctx , viewModel , child) {
          print("data02 Consumer build方法被执行");
          return Text('当前计数: ${viewModel.counter}', style: TextStyle(fontSize: 30),);
        },
      ),
    );
  }
}
