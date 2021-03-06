import 'package:flutter/material.dart';
import 'package:receitas_navegacao/routes/routes.dart';
import './screens/tab_viewer_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/settings_screen.dart';
import './screens/meal_detail_screen.dart';
import './models/meal.dart';
import './models/settings.dart';
import './dummy/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _favoriteMeals = [];
  Settings settings = Settings();
  List<Meal> _meals = DUMMY_MEALS;

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _meals = DUMMY_MEALS.where((meal) {
        final bool filterGluttenFree =
            settings.isGlutenFree && !meal.isGlutenFree;
        final bool filterLactose =
            settings.isLactoseFree && !meal.isLactoseFree;
        final bool filterVegan = settings.isVegan && !meal.isVegan;
        final bool filterVegetarian =
            settings.isVegetarian && !meal.isVegetarian;

        return !filterGluttenFree &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();

      print(_meals.length);
    });
  }

  void _setMealAsFavorite(meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool isMealFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas (Navegação)',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline2: TextStyle(
                fontSize: 30,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        Routes.HOME: (context) => TabViewerScreen(_favoriteMeals),
        Routes.CATEGORY_MEALS: (context) => CategoryMealsScreen(_meals),
        Routes.SETTINGS: (context) => SettingsScreen(settings, _filterMeals),
        Routes.MEAL_DETAIL: (context) => MealDetailScreen(_setMealAsFavorite, isMealFavorite),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => TabViewerScreen(_favoriteMeals),
        );
      },
    );
  }
}
