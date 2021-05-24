import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/product/products_grid.dart';
import '../providers/products_provider.dart';

enum popupOptions {
  showOnlyFavorites,
  showAll,
}

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
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (val) {
              if (val == popupOptions.showOnlyFavorites) {
                productsProvider.showFavorites();
                return;
              }

              productsProvider.showAll();
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Show only favorites'),
                value: popupOptions.showOnlyFavorites,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: popupOptions.showAll,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(products: _products),
    );
  }
}
