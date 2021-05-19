import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal);

  void _handleClickItem() {
    print('clickou');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleClickItem,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black54,
                    ),
                    width: 300,
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.schedule),
                      const SizedBox(width: 5),
                      Text('${meal.duration} min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.list_alt),
                      const SizedBox(width: 5),
                      Text(meal.complexityReadableForHuman)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.attach_money_rounded),
                      const SizedBox(width: 5),
                      Text(meal.costReadableForHuman)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
