import 'dart:math';

import 'package:flutter/foundation.dart';

import 'cart_provider.dart';

class Order {
  final String id;
  final double totalAmount;
  final List<CartItem> cartItems;
  final DateTime date;

  Order({
    @required this.id,
    @required this.totalAmount,
    @required this.cartItems,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  int get itemsCount {
    return _orders.length;
  }

  void createOrder(List<CartItem> cartItems, double totalAmount) {
    _orders.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        totalAmount: totalAmount,
        cartItems: cartItems,
        date: DateTime.now(),
      ),
    );

    // cart.clearItems();

    notifyListeners();
  }
}
