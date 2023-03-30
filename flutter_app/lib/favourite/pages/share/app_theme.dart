import 'package:flutter/material.dart';

class HYAppTheme {
  // 1.共有属性
  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;

// 2.普通模式
  static final Color norTextColors = Colors.red;

    static final ThemeData norTheme = ThemeData(
    primaryColor: Colors.pink,
      canvasColor: Color.fromRGBO(255, 254, 222, 1),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: bodyFontSize),
        headline1: TextStyle(fontSize: smallFontSize, color: Colors.black87),
        headline2: TextStyle(fontSize: normalFontSize, color: Colors.black87),
        headline3: TextStyle(fontSize: largeFontSize, color: Colors.black87),
      )
  );


// 3.暗黑模式
  static final Color darkTextColors = Colors.green;

  static final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.grey,
//      canvasColor: Color.fromRGBO(255, 254, 222, 1),
      textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: normalFontSize, color: darkTextColors),
          headline1: TextStyle(fontSize: smallFontSize, color: Colors.black87),
    headline2: TextStyle(fontSize: normalFontSize, color: Colors.black87),
    headline3: TextStyle(fontSize: largeFontSize, color: Colors.black87),
      )
  );
}