import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.productId,
    @required this.price,
    @required this.imageUrl,
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

  double get totalAmount {
    double totalAmount = 0.00;
    _items.forEach((key, item) {
      totalAmount += (item.quantity * item.price);
    });
    return totalAmount;
  }

  void add(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (cartItemExistent) {
        return CartItem(
          id: cartItemExistent.id,
          productId: product.id,
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          quantity: (cartItemExistent.quantity + 1),
        );
      });

      notifyListeners();

      return;
    }

    _items.putIfAbsent(product.id, () {
      return CartItem(
        id: Random().nextDouble().toString(),
        productId: product.id,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        quantity: 1,
      );
    });

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearItems() {
    _items = {};
  }
}
