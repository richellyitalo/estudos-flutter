import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(
                  cartItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text(
              'R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
            ),
            trailing: Text('${cartItem.quantity} x')),
      ),
    );
  }
}
