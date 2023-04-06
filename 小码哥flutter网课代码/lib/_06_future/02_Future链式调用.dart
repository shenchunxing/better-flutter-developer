import 'dart:io';

main(List<String> args) {
  print ('start');

  Future(() {
    sleep(Duration(seconds: 2));
    return '第一次的结果';
  }).then((value) {
    print(value);
    sleep(Duration(seconds: 3));
    throw Exception('第二次异常');
  }).then((value) {
    print(value);
    sleep(Duration(seconds: 3));
    return '第三次的结果';
  }).then((value) {
    print(value);
  }).catchError((error) {
    print(error);
  });

  print ('end');
}