import 'dart:io';
import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final isIOS = Platform.isIOS;

  Future<void> _openModalFormTransaction(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            child: TransactionForm(_addTransaction),
          );
        });
  }

  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Mensalidade antiga',
      value: 450.55,
      date: DateTime.now().subtract(
        Duration(days: 9),
      ),
    ),
    Transaction(
        id: 't33',
        title: 'Compras mercado',
        value: 450.55,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
      id: 't2',
      title: 'Mensalidade Internet',
      value: 350.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Mensalidade lá na frente',
      value: 600.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  bool _showingGraph = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = new Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date ?? DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  Widget _getIconAppBar(IconData iconData, Function onClick) {
    return isIOS
        ? GestureDetector(
            child: Icon(iconData),
            onTap: onClick,
          )
        : IconButton(
            icon: Icon(iconData),
            onPressed: onClick,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final iconList = isIOS ? CupertinoIcons.list_dash : Icons.list;
    final iconChart = isIOS ? CupertinoIcons.chart_bar : Icons.bar_chart;

    final List<Widget> actionsAppBar = <Widget>[
      if (isLandscape)
        _getIconAppBar(
          _showingGraph ? iconList : iconChart,
          () {
            setState(() {
              _showingGraph = !_showingGraph;
            });
          },
        ),
      _getIconAppBar(
        isIOS ? CupertinoIcons.add : Icons.add,
        () => _openModalFormTransaction(context),
      ),
    ];
    final PreferredSizeWidget appBar = isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas semanais1'),
            trailing: Row(
              children: actionsAppBar,
              mainAxisSize: MainAxisSize.min,
            ),
          )
        : AppBar(
            title: Text('Despesas semanais'),
            actions: actionsAppBar,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    // final Widget body =

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Mostrar gráfico'),
            //       Switch.adaptive(
            //         activeColor: Theme.of(context).accentColor,
            //         value: _showingGraph,
            //         onChanged: (value) {
            //           setState(() {
            //             _showingGraph = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (!isLandscape || (isLandscape && _showingGraph))
              Container(
                height: availableHeight * (isLandscape ? 0.9 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape || !_showingGraph)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openModalFormTransaction(context),
            ),
    );
  }
}
