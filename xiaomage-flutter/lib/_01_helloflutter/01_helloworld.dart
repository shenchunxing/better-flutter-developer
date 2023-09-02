import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(title: Text("第一个flutter程序"),),
        body: Center(
          child: Text("hello world",style: TextStyle(fontSize: 40,color: Colors.red),),
        ),
      ),
    )
  );
}