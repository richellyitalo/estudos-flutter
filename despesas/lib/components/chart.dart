import 'dart:math';

import 'package:despesas/components/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDayDate = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDayDate.day;
        bool sameMonth = recentTransactions[i].date.month == weekDayDate.month;
        bool sameYear = recentTransactions[i].date.year == weekDayDate.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDayDate)[0],
        'value': totalSum,
      };
    });
  }

  double get _weekTotalTransaction => groupedTransactions.fold(
        0.0,
        (sum, trans) => sum + (trans['value'] as double),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map(
            (trans) {
              return Flexible( // ou usa apenas Expanded
                fit: FlexFit.tight,
                child: ChartBar(
                  label: trans['day'],
                  value: trans['value'],
                  percentage:
                      (trans['value'] as double) / _weekTotalTransaction,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
