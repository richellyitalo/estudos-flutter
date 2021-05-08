import 'package:flutter/material.dart';
import 'package:quiz/questionario.dart';
import 'package:quiz/resultado.dart';

main() => runApp(QuizApp());

class _QuizAppState extends State<QuizApp> {
  int _perguntaSelecionada = 0;
  int _pontuacaoTotal = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual seu jogo favorito?',
      'alternativas': [
        {'texto': 'God of war 2', 'pontuacao': 2},
        {'texto': 'Def Jam', 'pontuacao': 8},
        {'texto': 'CSGO', 'pontuacao': 1},
        {'texto': 'Legacy of kain', 'pontuacao': 10},
      ]
    },
    {
      'texto': 'Qual seu time do coração?',
      'alternativas': [
        {'texto': 'Vasco da gama', 'pontuacao': 9},
        {'texto': 'Flamengo', 'pontuacao': 5},
        {'texto': 'Grêmio', 'pontuacao': 2},
        {'texto': 'Chelsea', 'pontuacao': 10},
      ]
    },
    {
      'texto': 'Qual sua linguagem de programação favorita?',
      'alternativas': [
        {'texto': 'PHP', 'pontuacao': 8},
        {'texto': 'Javascript', 'pontuacao': 7},
        {'texto': 'Python', 'pontuacao': 10},
        {'texto': 'Java', 'pontuacao': 1},
      ]
    }
  ];

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }

    print(_pontuacaoTotal);
  }

  void _recomecarResposta() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
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
          : Resultado(_pontuacaoTotal),
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
