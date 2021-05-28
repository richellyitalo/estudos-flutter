import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import 'components/cart_item_widget.dart';
import '../../widgets/main_drawer.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final Orders orderProvider = Provider.of<Orders>(context, listen: true);
    final List<CartItem> cartItems = cartProvider.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 5),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total'),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: cartItems.length == 0
                        ? null
                        : () {
                            orderProvider.createOrder(
                                cartItems, cartProvider.totalAmount);
                            cartProvider.clearItems();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Compra realizada com sucesso!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                    child: Text('Comprar'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          if (cartItems.length == 0)
            Card(
              margin: EdgeInsets.fromLTRB(25, 25, 25, 5),
              color: Colors.yellow.shade50,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Não há itens no carrinho... :('),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(cartItems[index]);
                },
              ),
            )
        ],
      ),
      drawer: MainDrawer()
    );
  }
}
