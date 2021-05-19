import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da receita'),
      ),
      body: Container(
        child: Text('Detalhe de ${meal.title}'),
      ),
    );
  }
}
