import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Parabéns!', style: TextStyle(fontSize: 35)),
          Image(image: AssetImage('images/congrats.gif'))
        ]);
  }
}
