import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Parabéns!', style: TextStyle(fontSize: 35)),
          Image(
              image: NetworkImage(
                  'https://media0.giphy.com/media/n5VaQoW39Z9S0/giphy.gif?cid=ecf05e47qkhmymic2bpv9gaokbrfbj58nylh65x0rdhwadto&rid=giphy.gif&ct=g'))
        ]);
  }
}
