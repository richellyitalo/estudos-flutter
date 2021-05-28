import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/main_drawer.dart';
import '../../providers/order_provider.dart';
import 'components/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Orders ordersProvider = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.itemsCount,
        itemBuilder: (context, index) {
          return OrderWidget(ordersProvider.orders[index]);
        },
      ),
      drawer: MainDrawer(),
    );
  }
}
