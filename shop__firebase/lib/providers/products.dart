import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import './product.dart';
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class Products with ChangeNotifier {
  Uri _baseUrl = Uri.parse('${Constants.BASE_URL}products');
  List<Product> _items = [];
  String _token;
  String _userId;

  Products([
    this._token,
    this._userId,
    this._items = const [],
  ]);

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl.json?auth=$_token'));
    final data = json.decode(response.body);

    final favoriteProducts = await _getFavoriteProducts();

    _items.clear();

    data.forEach((productId, product) {
      final bool isFavorite = favoriteProducts == null
          ? false
          : favoriteProducts[productId] ?? false;

      _items.add(Product(
        id: productId,
        title: product['title'],
        price: product['price'],
        description: product['description'],
        imageUrl: product['imageUrl'],
        isFavorite: isFavorite,
      ));
    });

    notifyListeners();

    return;
  }

  Future<Map<String, dynamic>> _getFavoriteProducts() async {
    final response = await http.get(Uri.parse(
        '${Constants.BASE_URL}/userFavorites/$_userId.json?auth=$_token'));
    return jsonDecode(response.body);
  }

  Future<void> addProduct(Product newProduct) async {
    final productJSON = json.encode({
      'title': newProduct.title,
      'price': newProduct.price,
      'description': newProduct.description,
      'imageUrl': newProduct.imageUrl,
    });

    final response = await http.post(
      Uri.parse('$_baseUrl.json?auth=$_token'),
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

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      await http.put(
        Uri.parse('$_baseUrl/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index == -1) {
      return;
    }
    final Product productBackup = _items[index];

    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();

    final response =
        await http.delete(Uri.parse('$_baseUrl/$id/.json?auth=$_token'));
    if (response.statusCode >= 400) {
      _items.insert(0, productBackup);
      notifyListeners();

      throw HttpException('Ocorreu um problema');
    }

    return response;
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
