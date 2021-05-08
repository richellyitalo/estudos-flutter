import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final Function fnSelecionarResposta;

  Resposta(this.texto, this.fnSelecionarResposta);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        child: Text(texto),
        onPressed: fnSelecionarResposta,
      ),
    );
  }
}
