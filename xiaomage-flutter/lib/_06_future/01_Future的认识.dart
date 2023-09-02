import 'package:flutter/material.dart';
import 'dart:io';

main(List<String> args) {
   print ('main start');
   // 发送一个网络请求
   var future = getNetworkData();

  // 2.拿到结果(dynamic)
  // then后面的回调函数什么时候被执行?
  // 需要在Future(函数)有结果, 才执行下面的回调函数

  future.then((value) {
    print(value);
  }).catchError((err) {
     print("执行catchError代码:$err -------------");
   }).whenComplete(() {
    print("代码执行完成");
  });

   print("main end");
}

Future<String> getNetworkData() {
  return Future<String>(() {
    // 1.将耗时的操作包裹到Future的回调函数中
    // 1> 只要有返回结果, 那么就执行Future对应的then的回调(Promise-resolve)
    // 2> 如果没有结果返回(有错误信息), 需要在Future回调中抛出一个异常(Promise-reject)
     sleep(Duration(seconds: 3));
     throw Exception('错误信息');
  });
}