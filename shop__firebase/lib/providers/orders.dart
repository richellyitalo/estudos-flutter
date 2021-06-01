import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import '../utils/constants.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}

class Orders with ChangeNotifier {
  final _baseUrl = '${Constants.BASE_URL}orders';

  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final DateTime date = DateTime.now();
    final totalAmount = cart.totalAmount;

    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode({
        'total': totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values.map((cartItem) {
          return {
            'id': cartItem.id,
            'productId': cartItem.productId,
            'title': cartItem.title,
            'quantity': cartItem.quantity,
            'price': cartItem.price,
          };
        }).toList(),
      }),
    );

    var responseObject = jsonDecode(response.body);

    _items.insert(
      0,
      Order(
        id: responseObject['name'],
        total: totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    cart.clear();

    notifyListeners();

    return response;
  }

  
  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                price: item['price'],
                productId: item['productId'],
                quantity: item['quantity'],
                title: item['title'],
              );
            }).toList(),
          ),
        );
      });
      notifyListeners();
    }

    _items = loadedItems.reversed.toList();
    return Future.value();
  }
}
