import 'package:flutter/material.dart';

// Criado apenas como demonstração
class CounterState {
  int _counter = 1;

  void inc() => _counter++;
  void dec() => _counter--;

  int get counter => _counter;
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({@required Widget child}) : super(child: child);

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
