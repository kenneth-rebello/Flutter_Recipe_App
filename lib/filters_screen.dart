import 'package:flutter/material.dart';
import './main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;
  bool _vegan = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilters['glutenFree'];
    _lactoseFree = widget.currentFilters['lactoseFree'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
  }

  Widget buildSwitchTile(
      String title, String description, bool currentValue, Function updater) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updater,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selected = {
                'glutenFree': _glutenFree,
                'lactoseFree': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan
              };
              widget.saveFilters(selected);
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selections',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTile('Gluten Free', 'Only include gluten-free meals',
                    _glutenFree, (value) {
                  setState(() {
                    _glutenFree = value;
                  });
                }),
                buildSwitchTile('Lactose Free',
                    'Only include lactose-free meals', _lactoseFree, (value) {
                  setState(() {
                    _lactoseFree = value;
                  });
                }),
                buildSwitchTile(
                    'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                    (value) {
                  setState(() {
                    _vegetarian = value;
                  });
                }),
                buildSwitchTile('Vegan', 'Only include vegan meals', _vegan,
                    (value) {
                  setState(() {
                    _vegan = value;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
