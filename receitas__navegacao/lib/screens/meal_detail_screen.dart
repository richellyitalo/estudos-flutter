import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../components/meal_detail/meal_title.dart';
import '../components/meal_detail/meal_content.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onHandleFavoriteMeal;
  final Function(Meal) isMealFavorite;

  const MealDetailScreen(this.onHandleFavoriteMeal, this.isMealFavorite);

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da receita'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            MealTitle('Ingredientes'),
            MealContent(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            MealTitle('Passos'),
            MealContent(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(meal) ? Icons.star_border : Icons.star,
        ),
        onPressed: () {
          // Navigator.of(context).pop(meal.title);
          onHandleFavoriteMeal(meal);
        },
      ),
    );
  }
}
