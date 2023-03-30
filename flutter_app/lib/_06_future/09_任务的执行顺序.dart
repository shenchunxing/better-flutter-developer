import 'dart:async';

/**
 * 1、main函数先执行，所以main start和main end先执行，没有任何问题；
    2、main函数执行过程中，会将一些任务分别加入到EventQueue和MicrotaskQueue中；
    3、task7通过scheduleMicrotask函数调用，所以它被最早加入到MicrotaskQueue，会被先执行；
    4、然后开始执行EventQueue，task1被添加到EventQueue中被执行；
    5、通过final future = Future(() => null);创建的future会被按顺序添加到EventQueue中，所以会执行task6；
    6、一次在EventQueue中添加task2、task3、task5被执行；
    7、task4属于微任务事件, 等task2所在的事件队列一执行完成, 就会执行MicrotaskQueue, 所以会在task5之后执行task4任务
    8、task8、task9、task10一次添加到EventQueue被执行；
 */
main() {
  print ('main start');

  Future(() {
    print('task1');
  });

  final future = Future(() {
     return null;
  });

  Future(() { //task4属于微任务事件, 等task2所在的事件队列一执行完成, 就会执行MicrotaskQueue, 所以会在task5之后执行task4任务
    print('task2');
  }).then((value) {
    print('task3');
    scheduleMicrotask(() {
      print('task4');
    });
  }).then((value) {
    print('task5');
  });

  future.then((value){
    print('task6');
  });

  scheduleMicrotask(() { //微任务优先执行
    print('task7');
  });

  Future(() { //task8 task9 task10
    print('task8');
  }).then((value) {
    Future(() {
      print('task9');
    }).then((value) {
      print('task10');
    });
  });

  print ('main end');
}