import 'package:flutter/material.dart';

main() => runApp(QuizApp());

class _QuizAppState extends State<QuizApp> {
  int _respostaSelecionada = 0;

  void _responder() {
    setState(() {
      _respostaSelecionada++;
    });
    print('Resposta: $_respostaSelecionada');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> questions = [
      'Qual seu jogo preferido?',
      'Qual seu time preferido?',
      'Qual seu time preferido#3?',
      'Qual seu time preferido#4?',
      'Qual seu time preferido#5?',
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz App by Ricly',
          ),
        ),
        body: Column(
          children: <Widget>[
            Text(questions.elementAt(_respostaSelecionada)),
            ElevatedButton(child: Text('Resposta 1'), onPressed: _responder),
            ElevatedButton(child: Text('Resposta 2'), onPressed: _responder),
            ElevatedButton(child: Text('Resposta 3'), onPressed: _responder),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("olá");
            },
            tooltip: 'Faça algo',
            child: const Icon(Icons.access_alarm)),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}
