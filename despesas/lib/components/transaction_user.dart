import 'dart:math';

import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'transaction_form.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Compras mercado1',
        value: 450.55,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Mensalidade Internet',
        value: 350.00,
        date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = new Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TransactionForm(_addTransaction),
      TransactionList(_transactions),
    ]);
  }
}
