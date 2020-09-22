import 'package:flutter/material.dart';
import './models/dummy_data.dart';

class MealDetails extends StatelessWidget {
  static const routeName = '/meal_details';

  Widget buildSection(BuildContext context, String secTitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        secTitle,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 300,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: child,
        ),
        Divider(
          thickness: 3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSection(context, "Ingredients"),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (ctx, idx) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(selectedMeal.ingredients[idx]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSection(context, "Steps"),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (ctx, idx) => ListTile(
                  leading: CircleAvatar(
                    child: Text("# ${idx + 1}"),
                  ),
                  title: Text(selectedMeal.steps[idx]),
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
