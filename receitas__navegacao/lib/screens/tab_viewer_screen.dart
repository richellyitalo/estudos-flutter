import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabViewerScreen extends StatefulWidget {
  @override
  _TabViewerScreenState createState() => _TabViewerScreenState();
}

class _TabViewerScreenState extends State<TabViewerScreen> {
  final List<Map<String, Object>> _screensOptions = [
    {'title': 'Categorias', 'screen': CategoriesScreen()},
    {'title': 'Receitas favoritas', 'screen': FavoritesScreen()},
  ];

  int _selectedScreenIndex = 0;

  _selectWidget(index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_screensOptions[_selectedScreenIndex]['title']),
        ),
      ),
      body: _screensOptions[_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedScreenIndex,
        onTap: _selectWidget,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
