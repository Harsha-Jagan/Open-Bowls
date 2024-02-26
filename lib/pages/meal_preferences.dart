import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/classes/user.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../util/api.dart';
import '../widgets/meal_options_widget.dart';
import 'services/database.dart';

class MealPreferences extends StatefulWidget {
  const MealPreferences({Key? key}) : super(key: key);

  @override
  _MealPreferencesState createState() => _MealPreferencesState();
}

class _MealPreferencesState extends State<MealPreferences> {
  // State variables
  String selectedProtein = 'Chicken';
  bool hasFridge = false;
  bool hasStove = false;
  bool hasPans = false; // Added variable for pans
  bool hasPots = false;
  CustomerData? userProfile;
  final TextEditingController existingIngredientsController =
      TextEditingController();
  double budget = 10;
  int peopleToFeed = 1;
  List<String> proteins = [
    'Chicken',
    'Fish',
    'Tofu',
    'Beef',
    'Lentils',
    'Pork',
    'Eggs'
  ];

  StreamSubscription<CustomerData>? _customerDataStreamSubscription;
  @override
  void dispose() {
    _customerDataStreamSubscription?.cancel(); // Cancel the subscription
    existingIngredientsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    final person = Provider.of<Customer?>(context,
        listen: false); // listen: false is important here
    if (person != null) {
      // Using a listener to the stream
      DbService(uid: person.uid).dataFromFS.listen((CustomerData custdata) {
        if (mounted) {
          SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
                userProfile = custdata;
              }));
          print('is this getting called hello');
        }
      });
    }
  }

  Future<void> _fetchUserProfile() async {
    final userProvider = Provider.of<CustomerData>(context);
    print(userProvider.uid);

    setState(() {
      userProfile = userProvider;
    });
  }

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Customer?>(context);

    return StreamBuilder<CustomerData>(
        stream: DbService(uid: person!.uid).dataFromFS,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomerData? custdata = snapshot.data;

            String var1 = custdata!.fname.toString();
            String var2 = custdata.lname.toString();
            String var3 = custdata.gender.toString();
            int? var4 = custdata.age;

            return Scaffold(
              appBar: AppBar(
                title: const Text('Healthy Meals on a Budget'),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildIntroText(),
                    const SizedBox(height: 20),
                    _buildExistingIngredientsField(),
                    const SizedBox(height: 20),
                    _buildProteinDropdown(),
                    _buildSwitchListTile(
                        title: 'Do you have a fridge?',
                        value: hasFridge,
                        onChanged: (value) =>
                            setState(() => hasFridge = value)),
                    _buildSwitchListTile(
                        title: 'Do you have a stove?',
                        value: hasStove,
                        onChanged: (value) => setState(() => hasStove = value)),
                    _buildSwitchListTile(
                        title: 'Do you have pans?',
                        value: hasPans,
                        onChanged: (value) => setState(
                            () => hasPans = value) // Added switch for pans
                        ),
                    _buildSwitchListTile(
                        title: 'Do you have pots?',
                        value: hasPots,
                        onChanged: (value) => setState(
                            () => hasPots = value) // Added switch for pots
                        ),
                    _buildBudgetSlider(),
                    _buildPeopleToFeedCounter(),
                    _buildGetMealSuggestionsButton(),
                    const SizedBox(height: 20),
                    _buildNutritionInfoSection(),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }

  Widget _buildIntroText() {
    return const Text(
      'Find the best meals for your budget, kitchen, and pantry!',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildExistingIngredientsField() {
    return TextFormField(
      controller: existingIngredientsController,
      decoration: const InputDecoration(
        labelText: 'Existing Ingredients',
        hintText: 'e.g., canned beans, tomatoes',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildProteinDropdown() {
    return ListTile(
      title: const Text('Select your protein'),
      trailing: DropdownButton<String>(
        value: selectedProtein,
        onChanged: (newValue) => setState(() => selectedProtein = newValue!),
        items: proteins
            .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSwitchListTile(
      {required String title,
      required bool value,
      required void Function(bool) onChanged}) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildBudgetSlider() {
    return ListTile(
      title: const Text('Budget (\$)'),
      subtitle: Slider(
        min: 5,
        max: 25,
        divisions: 20, // Adjusted for better granularity
        value: budget,
        label: budget.round().toString(),
        onChanged: (value) => setState(() => budget = value),
      ),
    );
  }

  Widget _buildPeopleToFeedCounter() {
    return ListTile(
      title: const Text('People to Feed'),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => setState(() =>
                  peopleToFeed = (peopleToFeed > 1) ? peopleToFeed - 1 : 1)),
          Text('$peopleToFeed'),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => peopleToFeed++)),
        ],
      ),
    );
  }

  Widget _buildGetMealSuggestionsButton() {
    return ElevatedButton(
      onPressed: _handleGetMealSuggestions,
      child: const Text('Get Meal Suggestions'),
    );
  }

  void _handleGetMealSuggestions() {
    // Assuming sendMealPreferences is defined elsewhere and works asynchronously
    sendMealPreferences(
      protein: selectedProtein,
      budget: budget,
      peopleToFeed: peopleToFeed,
      hasFridge: hasFridge,
      hasStove: hasStove,
      hasPans: hasPans, // Pass the hasPans state
      hasPots: hasPots, // Pass the hasPots state
      existingIngredients: existingIngredientsController.text,
      userProfile: userProfile,
    ).then((mealOptions) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MealOptionsCarousel(mealOptions: mealOptions)),
      );
    }).catchError((error) {
      // Handle error, e.g., show an error message
      print("Error sending meal preferences: $error");
    });
  }

  Widget _buildNutritionInfoSection() {
    // This method would build a section displaying nutrition information, similar to the flashcards example provided before
    // Example data for nutrition facts. You could replace this with dynamic data if available.
    final List<Map<String, String>> nutritionFacts = [
      {
        'title': 'Fact 1',
        'description':
            'Bananas are a great source of potassium, which is vital for heart health.',
      },
      {
        'title': 'Fact 2',
        'description':
            'Spinach is loaded with tons of nutrients in a low-calorie package.',
      },
      {
        'title': 'Fact 3',
        'description':
            'Eggs are among the most nutritious foods on the planet, containing a little bit of almost every nutrient you need.',
      },
      // Add more facts as needed
    ];

    return Column(
      children: nutritionFacts
          .map((fact) => Card(
                elevation:
                    4.0, // Gives a slight shadow to the card for a subtle 3D effect
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    fact['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(fact['description']!),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
