import 'package:flutter/material.dart';
import './components/transaction_user.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeApp());
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Despesas semanais')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.greenAccent,
                child: Text(
                  'Gráfico de despesas',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TransactionUser(),
          ],
        ),
      ),
    );
  }
}
