import 'package:flutter/material.dart';

import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
