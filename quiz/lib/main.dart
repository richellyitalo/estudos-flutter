import 'package:flutter/material.dart';
import 'package:quiz/questionario.dart';
import 'package:quiz/resultado.dart';

main() => runApp(QuizApp());

class _QuizAppState extends State<QuizApp> {
  int _perguntaSelecionada = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual seu jogo favorito?',
      'alternativas': [
        {'texto': 'God of war 2', 'nota': 2},
        {'texto': 'Def Jam', 'nota': 8},
        {'texto': 'CSGO', 'nota': 1},
        {'texto': 'Legacy of kain', 'nota': 10},
      ]
    },
    {
      'texto': 'Qual seu time do coração?',
      'alternativas': [
        {'texto': 'Vasco da gama', 'nota': 9},
        {'texto': 'Flamengo', 'nota': 5},
        {'texto': 'Grêmio', 'nota': 2},
        {'texto': 'Chelsea', 'nota': 10},
      ]
    },
    {
      'texto': 'Qual sua linguagem de programação favorita?',
      'alternativas': [
        {'texto': 'PHP', 'nota': 8},
        {'texto': 'Javascript', 'nota': 7},
        {'texto': 'Python', 'nota': 10},
        {'texto': 'Java', 'nota': 1},
      ]
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
