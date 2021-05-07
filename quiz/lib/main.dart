import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

main() => runApp(QuizApp());

class _QuizAppState extends State<QuizApp> {
  int _respostaSelecionada = 0;
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
        _respostaSelecionada++;
      });
    }
  }

  bool get temPerguntaSelecionada {
    return _respostaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<String> alternativas = temPerguntaSelecionada
        ? _perguntas[_respostaSelecionada]['alternativas']
        : null;
    List<Widget> alternativasWidget = temPerguntaSelecionada
         ? alternativas.map((t) => Resposta(t, _responder)).toList()
         : null;
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
            ? Column(
                children: <Widget>[
                  Questao(_perguntas[_respostaSelecionada]['texto']),
                  ...alternativasWidget
                ],
              )
            : null,
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}
