import 'dart:io';

main() {
  print("main start");
  getdata().then((value) {
     print('最终结果：$value');
  }).catchError((err){
    print(err);
  });
  print("main end");
}

//异步执行。await可以避免回调地狱
Future getdata() async {
  var res1 = await getNetworkData('argument1');
  print(res1);
  var res2 = await getNetworkData(res1);
  print(res2);
  var res3 = await getNetworkData(res2);
  return res3;
}

Future getNetworkData(String arg) {
  return Future(() {
    sleep(Duration(seconds: 3));
    return "Hello World" + arg;
  });
}