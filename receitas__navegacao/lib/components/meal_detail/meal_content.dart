import 'package:flutter/material.dart';

class MealContent extends StatelessWidget {
  final Widget child;
  
  const MealContent(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
