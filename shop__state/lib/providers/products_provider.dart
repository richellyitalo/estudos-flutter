import 'dart:math';

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product newProduct) {
    newProduct.id = Random().nextDouble().toString();
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    int index = _items.indexWhere((prod) => prod.id == product.id);
    if (index == -1) {
      return;
    }

    _items[index] = product;

    notifyListeners();
  }

  void removeProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    int index = _items.indexWhere((prod) => prod.id == product.id);
    if (index == -1) {
      return;
    }

    _items.removeWhere((prod) => prod.id == product.id);

    notifyListeners();
  }
}

// bool _showFavorites = false;

// List<Product> get items {
//     if (_showFavorites) {
//       return _items.where((item) => item.isFavorite).toList();
//     }

//     return [..._items];
//   }

//   void showFavorites() {
//     _showFavorites = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _showFavorites = false;
//     notifyListeners();
//   }
