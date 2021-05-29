import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../util/app_routes.dart';
import '../../../providers/products_provider.dart';

class ProductLoop extends StatelessWidget {
  final Product product;

  const ProductLoop(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        title: Text(product.title),
        subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_NEW,
                    arguments: product,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Remover produto'),
                        content: Text('Deseja mesmo remover o produto?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Não',
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Sim'),
                            onPressed: () {
                              Provider.of<ProductsProvider>(context,
                                      listen: false)
                                  .removeProduct(product);

                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Produto removido!'),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
