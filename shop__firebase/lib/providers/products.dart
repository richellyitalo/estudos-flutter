import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import './product.dart';

class Products with ChangeNotifier {
  Uri _baseUrl = Uri.parse(
      'https://curso-cod3r-flutter---shop-default-rtdb.asia-southeast1.firebasedatabase.app/products');
  List<Product> _items = [];

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    final data = json.decode(response.body);

    _items.clear();

    data.forEach((productId, product) {
      _items.add(Product(
        id: productId,
        title: product['title'],
        price: product['price'],
        description: product['description'],
        imageUrl: product['imageUrl'],
        isFavorite: product['isFavorite'],
      ));
    });

    notifyListeners();
  }

  Future<void> addProduct(Product newProduct) async {
    final productJSON = json.encode({
      'title': newProduct.title,
      'price': newProduct.price,
      'description': newProduct.description,
      'imageUrl': newProduct.imageUrl,
      'isFavorite': false,
    });

    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: productJSON,
    );

    _items.add(Product(
      id: json.decode(response.body)['name'],
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl,
    ));

    notifyListeners();

    return response;
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}

// bool _showFavoriteOnly = false;

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();

// }
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
