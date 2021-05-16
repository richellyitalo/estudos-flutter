import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemoveTransaction;

  TransactionList(this.transactions, this.onRemoveTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: constraint.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nenhuma transação cadastrada',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/empty.png',
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions.map((tr) {
            return TransactionItem(
              key: ValueKey(tr.id),
              transaction: tr,
              onRemoveTransaction: onRemoveTransaction,
            );
          }).toList());
    // ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       final tr = transactions[index];
    //       return TransactionItem(
    //         transaction: tr,
    //         onRemoveTransaction: onRemoveTransaction,
    //       );
    //     },
    //   );
  }
}
