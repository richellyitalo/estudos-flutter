import 'package:flutter/material.dart';
import 'package:quiz/questionario.dart';
import 'package:quiz/resultado.dart';

main() => runApp(QuizApp());

class _QuizAppState extends State<QuizApp> {
  int _perguntaSelecionada = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual seu jogo favorito?',
      'alternativas': ['God of war 2', 'Def Jam', 'CSGO', 'PES 2021']
    },
    {
      'texto': 'Qual seu time do coração?',
      'alternativas': ['Vasco da gama', 'Flamengo', 'Grêmio', 'Chelsea']
    },
    {
      'texto': 'Qual sua linguagem de programação favorita?',
      'alternativas': ['PHP', 'Javascript', 'Python', 'Java']
    }
  ];

  void _responder() {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
      });
    }
  }

  void _recomecarResposta() {
    setState(() {
      _perguntaSelecionada = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    // for (String alternativa in perguntas[_respostaSelecionada]['alternativas']) {
    //   alternativasWidget.add(Resposta(alternativa, _responder));
    // }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App by Ricly',
        ),
      ),
      body: temPerguntaSelecionada
          ? Questionario(
              perguntas: _perguntas,
              perguntaSelecionada: _perguntaSelecionada,
              fnResponder: _responder,
            )
          : Resultado(),
      floatingActionButton: !temPerguntaSelecionada
          ? FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: _recomecarResposta,
              tooltip: 'Recomeçar questionário',
            )
          : null,
    ));
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}
