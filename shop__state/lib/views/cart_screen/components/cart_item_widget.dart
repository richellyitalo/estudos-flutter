import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
        ),
        child: Icon(
          Icons.delete_forever,
          size: 30,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(right: 40),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        cartProvider.removeItem(cartItem.productId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${cartItem.title} removido do carrinho'),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}
