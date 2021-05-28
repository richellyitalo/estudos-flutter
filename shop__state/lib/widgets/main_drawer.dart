import 'package:flutter/material.dart';

import '../util/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            padding: EdgeInsets.all(30),
            child: Text(
              'Shop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            curve: Curves.bounceIn,
          ),
          // AppBar(
          //   title: Text('Shop'),
          //   automaticallyImplyLeading: true,
          // ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Início'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('Produtos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}
