import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/products_overview_screen.dart';
import './util/app_routes.dart';
import './views/product_detail_screen.dart';
import 'views/cart_screen/cart_screen.dart';
import 'views/products_screen/products_screen.dart';
import 'views/orders_screen/orders_screen.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/order_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
        ),
        // home: ProductsOverView(),
        routes: {
          AppRoutes.HOME: (context) => ProductsOverView(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
          AppRoutes.CART: (context) => CartScreen(),
          AppRoutes.ORDERS: (context) => OrdersScreen(),
          AppRoutes.PRODUCTS: (context) => ProductsScreen(),
        },
      ),
    );
  }
}
