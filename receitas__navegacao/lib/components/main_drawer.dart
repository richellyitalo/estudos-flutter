import 'package:flutter/material.dart';
import '../routes/routes.dart';

class MainDrawer extends StatelessWidget {
  _drawerItem(IconData icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(
              'Vamos cozinhas?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _drawerItem(
            Icons.restaurant,
            'Categories',
            () => Navigator.of(context).pushReplacementNamed(Routes.HOME),
          ),
          _drawerItem(
            Icons.settings,
            'Settings',
            () => Navigator.of(context).pushReplacementNamed(Routes.SETTINGS),
          ),
        ],
      ),
    );
  }
}
