import 'package:flutter/material.dart';

enum Cost { Cheap, Fair, Expensive }

enum Complexity { Simple, Medium, Difficult }

class Meal {
  final String id;
  final List<String> categories;
  final Cost cost;
  final Complexity complexity;
  final String title;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  const Meal(
      {@required this.id,
      @required this.categories,
      @required this.cost,
      @required this.complexity,
      @required this.title,
      @required this.imageUrl,
      @required this.duration,
      @required this.ingredients,
      @required this.steps,
      @required this.isGlutenFree,
      @required this.isVegan,
      @required this.isVegetarian,
      @required this.isLactoseFree});
}
