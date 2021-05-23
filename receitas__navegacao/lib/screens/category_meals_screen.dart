import 'package:flutter/material.dart';
import '../components/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../dummy/dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoryMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;

    final List<Meal> meals = this
        .meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas da categoria'),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(meals[index]);
        },
      ),
    );
  }
}
