import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/main_drawer.dart';
import '../../providers/products_provider.dart';
import 'componentes/product_loop.dart';
import '../../util/app_routes.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento de Produtos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_NEW);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productsProvider.itemsCount,
          itemBuilder: (context, index) {
            return ProductLoop(productsProvider.items[index]);
          },
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
