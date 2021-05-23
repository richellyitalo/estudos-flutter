import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import 'product_tile.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key key,
    @required List<Product> products,
  })  : _products = products,
        super(key: key);

  final List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider(
          create: (context) => _products[index],
          child: ProductTile(),
        );
      },
    );
  }
}
