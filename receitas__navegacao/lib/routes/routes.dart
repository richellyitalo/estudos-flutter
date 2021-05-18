import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/category_meals_screen.dart';

class Routes {
  static const HOME = '/';
  static const CATEGORY_MEALS = '/category-meals';

  static final Map<String, Widget Function(BuildContext)> routes = {
    HOME: (context) => CategoriesScreen(),
    CATEGORY_MEALS: (context) => CategoryMealsScreen(),
  };
}
