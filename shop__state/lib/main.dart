import 'package:flutter/material.dart';
import './views/products_overview_screen.dart';
import './util/app_routes.dart';
import './views/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato'),
      home: ProductsOverView(),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (conext) => ProductDetailScreen(),
      },
    );
  }
}
