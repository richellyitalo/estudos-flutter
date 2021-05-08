import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;

  Resultado(this.pontuacao);

  String get textoResultado {
    if (pontuacao < 10) {
      return 'Regular';
    }

    if (pontuacao < 20) {
      return 'Muito bom!';
    }

    return 'Excelente!';
  }

  List<Icon> get estrelas {
    List colors = [Colors.yellow, Colors.grey, Colors.grey];

    if (pontuacao > 10) {
      colors = [Colors.yellow, Colors.yellow, Colors.grey];
    }

    if (pontuacao == 30) {
      colors = [Colors.yellow, Colors.yellow, Colors.yellow];
    }

    return colors
        .map((color) => Icon(Icons.star, color: color, size: 60))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(textoResultado, style: TextStyle(fontSize: 35)),
          Row(children: estrelas, mainAxisAlignment: MainAxisAlignment.center),
          Image(image: AssetImage('images/congrats.gif'))
        ]);
  }
}
