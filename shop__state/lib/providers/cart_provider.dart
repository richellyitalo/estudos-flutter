import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void add(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (cartItemExistent) {
        return CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          quantity: (cartItemExistent.quantity + 1),
        );
      });

      notifyListeners();

      return;
    }

    _items.putIfAbsent(product.id, () {
      return CartItem(
        id: product.id,
        title: product.title,
        price: product.price,
        quantity: 1,
      );
    });

    notifyListeners();
  }
}