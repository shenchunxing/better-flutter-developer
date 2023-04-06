
import 'package:flutter/material.dart';
import 'package:flutter_app/douban_app/home/home.dart';
import 'package:flutter_app/douban_app/subject/subject.dart';
import 'bottom_bar_item.dart';

List<HYBottomBarItem> items = [
  HYBottomBarItem("home", "首页"),
  HYBottomBarItem("subject", "书影音"),
  HYBottomBarItem("group", "小组"),
  HYBottomBarItem("mall", "市集"),
  HYBottomBarItem("profile", "我的"),
];

List<Widget> pages = [
  Home(),
  HYSubjectPage(),
  HYSubjectPage(),
  HYSubjectPage(),
  HYSubjectPage()
];