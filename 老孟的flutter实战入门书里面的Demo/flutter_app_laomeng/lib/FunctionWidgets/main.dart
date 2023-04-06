import 'package:flutter/material.dart';
import 'package:flutter_app_laomeng/FunctionWidgets/dragtargetdetailsexample.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dateselectors.dart';
import 'timeselectors.dart';
import 'popupmenubuttons.dart';
import 'alertdialogs.dart';
import 'borders.dart';
import 'drags.dart';
import 'interactiveviewers.dart';

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
      //国际化
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh'),
        const Locale('en'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Demo"),),
        body: InteractiveViewerDemo(),
      ),
    );
  }
}
