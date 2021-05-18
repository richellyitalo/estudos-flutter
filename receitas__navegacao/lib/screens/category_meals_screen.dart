import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas da categoria'),
      ),
      body: Center(
        child: Text('Receitas de ${category.id}'),
      ),
    );
  }
}
