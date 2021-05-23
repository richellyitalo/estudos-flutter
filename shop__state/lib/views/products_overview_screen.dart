import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../widgets/product/product_tile.dart';

class ProductsOverView extends StatelessWidget {
  final List<Product> _products = DUMMY_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Minha Loja'),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 3 / 2,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductTile(_products[index]);
        },
      ),
    );
  }
}
