import 'package:flutter/material.dart';
import 'package:frontend/pages/meal_preferences.dart';

class DietHomePage extends StatefulWidget {
  const DietHomePage({super.key});

  @override
  createState() => _DietHomePageState();
}

class _DietHomePageState extends State<DietHomePage> {
  // Placeholder for user preferences
  String selectedProtein = 'Chicken';
  double budget = 0.0;
  int peopleToFeed = 1;
  bool hasFridge = false;
  bool hasStove = false;

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
            // User input section for preferences
            // Implement dropdowns, switches, sliders, etc., for user input
            // For brevity, this example uses placeholders
            // const MealPreferences(),
            ElevatedButton(
              onPressed: () {
                // Implement your function to fetch meal suggestions
              },
              child: const Text('Get Suggestions'),
            ),
            // Nutrition tracker summary
            // Implement a real tracker based on user data
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Your Nutrition Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Placeholder for nutrition summary
          ],
        ),
      ),
    );
  }
}
