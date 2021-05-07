import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final Function quandoSelecionado;

  Resposta(this.texto, this.quandoSelecionado);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        child: Text(texto),
        onPressed: quandoSelecionado,
      ),
    );
  }
}
