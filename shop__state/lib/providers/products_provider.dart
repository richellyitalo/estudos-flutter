import 'package:flutter/material.dart';

import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  void add(Product product) {
    _items.add(product);
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
