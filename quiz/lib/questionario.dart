import 'package:flutter/material.dart';
import 'package:quiz/questao.dart';
import 'package:quiz/resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final Function(int) fnResponder;

  Questionario({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.fnResponder,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> alternativas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada]['alternativas']
        : null;

    List<Widget> alternativasWidget = temPerguntaSelecionada
        ? alternativas.map((opcao) {
            return Resposta(
                opcao['texto'], () => fnResponder(opcao['pontuacao']));
          }).toList()
        : null;

    return Column(
      children: <Widget>[
        Questao(perguntas[perguntaSelecionada]['texto']),
        ...alternativasWidget
      ],
    );
  }
}
