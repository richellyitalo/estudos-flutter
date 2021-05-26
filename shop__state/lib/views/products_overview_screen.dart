import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/app_routes.dart';

import '../models/product.dart';
import '../widgets/product/products_grid.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/badge.dart';

enum popupOptions {
  showOnlyFavorites,
  showAll,
}

class ProductsOverView extends StatefulWidget {
  @override
  _ProductsOverViewState createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  bool _showFavorites = false;

  _handleSelectPopupMenu(val) {
    setState(() {
      if (val == popupOptions.showOnlyFavorites) {
        _showFavorites = true;
        return;
      }

      _showFavorites = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final List<Product> _products = _showFavorites
        ? productsProvider.favoriteItems
        : productsProvider.items;

    // final CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Minha Loja'),
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _handleSelectPopupMenu,
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
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Badge(
                value: cartProvider.itemCount.toString(),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.CART);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ProductsGrid(products: _products),
    );
  }
}
