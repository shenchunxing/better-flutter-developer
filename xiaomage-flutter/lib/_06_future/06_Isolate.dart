import 'dart:isolate';

main() {
  print("main start");
  Isolate.spawn(calc,100); //异步计算求和
  print("main end");
}

void calc(int count) {
   var total = 0;
   for (int i = 0 ; i < count ;i++) {
     total += i;
   }
   print(total);
}