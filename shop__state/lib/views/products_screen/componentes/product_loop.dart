import 'package:flutter/material.dart';

import '../../../models/product.dart';

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
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
