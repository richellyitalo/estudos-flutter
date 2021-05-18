import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(
        meal.duration.toString(),
      ),
    );
  }
}
