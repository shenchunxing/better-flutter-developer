import 'dart:isolate';

main() async {
  print("main start");
single();
  print("main end");
}

//我们需要新的Isolate进行计算，并且将计算结果告知Main Isolate（也就是默认开启的Isolate）；
//Isolate 通过发送管道（SendPort）实现消息通信机制；
//我们可以在启动并发Isolate时将Main Isolate的发送管道作为参数传递给它；
//并发在执行完毕时，可以利用这个管道给Main Isolate发送消息；
void single() async{
  // 1.创建管道
  ReceivePort receivePort = ReceivePort();
  // 2.创建新的Isolate，默认的是main Isolate
  Isolate isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);
  // 3.监听管道
  receivePort.listen((message) {
    print(message);
    receivePort.close();
    isolate.kill();
  });
}

void foo(SendPort sendPort) {
  return sendPort.send('xxxxx');
}