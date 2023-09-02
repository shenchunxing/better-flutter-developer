
import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/pages/favor/favor.dart';
import 'package:flutter_app/favourite/pages/home/home.dart';

final List<Widget> pages = [
  HYHomeScreen(),
  HYFavorScreen(),
];

final List<BottomNavigationBarItem> items =[
  BottomNavigationBarItem(icon: Icon(Icons.home),label:'首页'),
  BottomNavigationBarItem(icon: Icon(Icons.star),label:'收藏'),
];