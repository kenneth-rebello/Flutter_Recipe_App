import 'package:flutter/material.dart';
import './meal_item.dart';
import './models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorite meals yet'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            id: favoriteMeals[idx].id,
            title: favoriteMeals[idx].title,
            imageUrl: favoriteMeals[idx].imageUrl,
            affordability: favoriteMeals[idx].affordability,
            complexity: favoriteMeals[idx].complexity,
            duration: favoriteMeals[idx].duration,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
