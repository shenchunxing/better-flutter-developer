import 'dart:io';

main(List<String> args) {
  print("main start");

  var result = getNetworkData().then((res) {
    print(res);//Hello World
  });
  print(result); //Instance of 'Future<Null>'

  print("main end");
}

/**
 * 解决两个问题:
 *  1.await必须在async函数中才能使用
 *  2.async函数返回的结果必须是一个Future
 */
Future getNetworkData() async {
//  await sleep(Duration(seconds: 3)); 这里因为flutter版本号的问题，导致无法使用await在sleep上
  return "Hello World";
}