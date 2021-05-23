import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/product/products_grid.dart';
import '../providers/products_provider.dart';

class ProductsOverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final List<Product> _products = productsProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Minha Loja'),
        ),
      ),
      body: ProductsGrid(products: _products),
    );
  }
}