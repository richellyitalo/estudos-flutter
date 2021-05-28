import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../util/app_routes.dart';
import '../../providers/cart_provider.dart';

class ProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);

    void _navigateToProductDetail() {
      Navigator.of(context)
          .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: _navigateToProductDetail,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) {
              return IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: product.toggleFavorite,
              );
            },
          ),
          title: Text(product.title),
          trailing: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cartProvider.add(product);

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} adicionado ao carrinho'),
                      duration: Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          cartProvider.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
