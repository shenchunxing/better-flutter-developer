import 'package:flutter/material.dart';
import 'package:flutter_app/favourite/model/meal_model.dart';
import 'package:flutter_app/favourite/pages/detail/detail_content.dart';
import 'package:flutter_app/favourite/pages/detail/detail_floating_button.dart';

class HYDetailScreen extends StatelessWidget {
  static const String routeName = '/detail';
  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as HYMealModel;
    return Scaffold(
      appBar: AppBar(title: Text(meal.title ?? ''),),
      body: HYDetailContent(meal),
      floatingActionButton: HYDetailFloatingButton(meal),
    );
  }
}
