
main(List<String> args) {
  test4();
}

//start
//end
//哈哈
void test1() {
  print("start");
  //传值
  Future.value('哈哈').then((value) {
    print(value);
  });

  print("end");
}

//start
//end
//123
void test2() {
  print("start");
  //错误
  Future.error('123').catchError((error) {
    print(error);
  });

  print("end");
}

//start
//end
//hello world
//hello world2
void test3() {
  print("start");
  //延迟
  Future.delayed(Duration(seconds: 3),() {
    return 'hello world';
  }).then((value) {
    print(value);
    return 'hello world2';
  }).then((value) {
    print(value);
  });

  print("end");
}

void test4() {
  print("start");
  print(getNetworkData());
  print("end");
}

Future getNetworkData() async {
  var result = await Future.delayed(Duration(seconds: 3) , () {
    return 'network data';
  });

  print('请求的数据:' + result);
  return '请求的数据:' + result;
}