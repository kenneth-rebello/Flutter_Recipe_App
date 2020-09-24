import 'package:flutter/material.dart';
import './models/meal.dart';
import './meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  final List<Meal> _availableMeals;

  CategoryMealsScreen(this._availableMeals);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String id = args['id'];
    final String title = args['title'];
    final categoryMeals = _availableMeals.where((meal) {
      return meal.categories.contains(id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            id: categoryMeals[idx].id,
            title: categoryMeals[idx].title,
            imageUrl: categoryMeals[idx].imageUrl,
            affordability: categoryMeals[idx].affordability,
            complexity: categoryMeals[idx].complexity,
            duration: categoryMeals[idx].duration,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
