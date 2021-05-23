import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabViewerScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabViewerScreen(this.favoriteMeals);

  @override
  _TabViewerScreenState createState() => _TabViewerScreenState();
}

class _TabViewerScreenState extends State<TabViewerScreen> {
  List<Map<String, Object>> _screensOptions;

  int _selectedScreenIndex = 0;

  _selectWidget(index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
  
  @override
  void initState() {
    super.initState();

    _screensOptions = [
      {'title': 'Categorias', 'screen': CategoriesScreen()},
      {'title': 'Receitas favoritas', 'screen': FavoritesScreen(widget.favoriteMeals)},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_screensOptions[_selectedScreenIndex]['title']),
        ),
      ),
      drawer: MainDrawer(),
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
