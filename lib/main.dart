import 'package:flutter/material.dart';

import './colors/colors.dart';
import './models/dummy_data.dart';
import './models/meal.dart';

import './tabs.dart';
import './category_meals_screen.dart';
import './meal_details_screen.dart';
import './filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      print(_filters);
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['glutenFree'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactoseFree'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingId = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingId >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingId);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        accentColor: Color.fromRGBO(255, 223, 0, 1),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                color: Color.fromRGBO(20, 51, 51, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetails.routeName: (ctx) =>
            MealDetails(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
    );
  }
}
