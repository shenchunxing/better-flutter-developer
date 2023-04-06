import 'package:flutter/material.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('同意协议',),
      ),
      body: HYContentBody(),//HYContentBody
    );
  }
}

class HYContentBody extends StatefulWidget {
  @override
  _HYContentBodyState createState() => _HYContentBodyState();
}

class _HYContentBodyState extends State<HYContentBody> {
  var flag = false;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
              value: flag,
              onChanged: (value) {
                setState(() {
                   flag = value!;
                });
              },
          ),
          Text('同意协议',style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}




