import 'package:flutter/material.dart';

import '../util/api.dart';
import '../widgets/meal_options_widget.dart';

class MealPreferences extends StatefulWidget {
  const MealPreferences({Key? key}) : super(key: key);

  @override
  createState() => _MealPreferencesState();
}

class _MealPreferencesState extends State<MealPreferences> {
  String selectedProtein = 'Chicken';
  bool hasFridge = false;
  bool hasStove = false;
  double budget = 50;
  int peopleToFeed = 1;
  List<String> proteins = ['Chicken', 'Fish', 'Tofu', 'Beef'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Meals on a Budget'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Find the best meals for your budget and kitchen!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            ..._buildPreferenceWidgets(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPreferenceWidgets() {
    return [
      ListTile(
        title: const Text('Select your protein'),
        trailing: DropdownButton<String>(
          value: selectedProtein,
          onChanged: (String? newValue) {
            setState(() {
              selectedProtein = newValue!;
            });
          },
          items: proteins.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
      SwitchListTile(
        title: const Text('Do you have a fridge?'),
        value: hasFridge,
        onChanged: (bool value) {
          setState(() {
            hasFridge = value;
          });
        },
      ),
      SwitchListTile(
        title: const Text('Do you have a stove?'),
        value: hasStove,
        onChanged: (bool value) {
          setState(() {
            hasStove = value;
          });
        },
      ),
      ListTile(
        title: const Text('Budget (\$)'),
        subtitle: Slider(
          min: 0,
          max: 100,
          divisions: 100,
          value: budget,
          label: budget.round().toString(),
          onChanged: (double value) {
            setState(() {
              budget = value;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('People to Feed'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (peopleToFeed > 1) {
                    peopleToFeed--;
                  }
                });
              },
            ),
            Text('$peopleToFeed'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  peopleToFeed++;
                });
              },
            ),
          ],
        ),
      ),
      ElevatedButton(
        onPressed: () {
          sendMealPreferences(
            protein: selectedProtein,
            budget: budget,
            peopleToFeed: peopleToFeed,
            hasFridge: hasFridge,
            hasStove: hasStove,
          ).then((mealOptions) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MealOptionsCarousel(mealOptions: mealOptions),
              ),
            );
          }).catchError((error) {
            // Handle error, e.g., show an error message
            print("Error sending meal preferences: $error");
          });
        },
        child: const Text('Get Meal Suggestions'),
      ),
    ];
  }
}
