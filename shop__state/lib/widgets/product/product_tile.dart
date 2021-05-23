import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../util/app_routes.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product);


  @override
  Widget build(BuildContext context) {
    void _navigateToProductDetail() {
      Navigator.of(context).pushNamed(
        AppRoutes.PRODUCT_DETAIL,
        arguments: product
      );
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
          leading: IconButton(
            icon: Icon(Icons.star),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(product.title),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
