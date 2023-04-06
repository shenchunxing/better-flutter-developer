import 'package:flutter/material.dart';
import 'linelayouts.dart';
import 'stacks.dart';
import 'wraps.dart';
import 'customlayouts.dart';
import 'juejin_me.dart';
import 'menu.dart';
import 'semi_circle.dart';
import 'containers.dart';
import 'sizeboxs.dart';
import 'expandeds.dart';
import 'cylinderchart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Demo"),),
        body: CylinderChart(),
      ),
    );
  }
}
