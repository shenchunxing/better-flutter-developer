import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Progresss extends StatefulWidget {
  @override
  _ProgresssState createState() => _ProgresssState();
}

class _ProgresssState extends State<Progresss> {
  @override
  Widget build(BuildContext context) {
    return progresssDemo1();
  }

  Widget progresssDemo1() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: 0.3,
          backgroundColor: Colors.greenAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
        CircularProgressIndicator(
          value: 0.3,
          backgroundColor: Colors.greenAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
        CupertinoActivityIndicator(
          radius: 20,
          color: Colors.red,
        ),
      ],
    );
  }
}
