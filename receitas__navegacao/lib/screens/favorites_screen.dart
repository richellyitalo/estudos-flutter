import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../components/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.length == 0) {
      return Center(
        child: Text('Não há refeições marcadas como favorita'),
      );
    } else {
      return Container(
        child: ListView.builder(
            itemCount: favoriteMeals.length,
            itemBuilder: (context, index) {
              return MealItem(favoriteMeals[index]);
            }),
      );
    }
  }
}
