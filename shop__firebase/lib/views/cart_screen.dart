import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_widget.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  Widget _showLoading() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: _isLoading
          ? _showLoading()
          : Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(25),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text(
                            'R\$${cart.totalAmount}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .title
                                  .color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        Spacer(),
                        TextButton(
                          child: Text(
                            'COMPRAR',
                          ),
                          onPressed: cartItems.toList().length == 0
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  await Provider.of<Orders>(context,
                                          listen: false)
                                      .addOrder(cart);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Pedido realizado com sucesso!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.itemsCount,
                    itemBuilder: (ctx, i) => CartItemWidget(cartItems[i]),
                  ),
                ),
              ],
            ),
    );
  }
}
