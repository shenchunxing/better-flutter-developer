import 'package:flutter/material.dart';
import 'user.dart';
import 'computer.dart';

void main() {
  final jsonInfo = {
    "nickname": "coderwhy",
    "level": 18,
    "courses": ["语文", "数学", "英语"],
    "register_date": "2222-2-22",
    "computer": {
      "brand": "MackBook",
      "price": "1000"
    }
  };

  final user = User.fromJson(jsonInfo);
  print(user);
}