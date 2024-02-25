import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../pages/recipe_page.dart';
import '../util/api.dart';
import '../util/class.dart';

class MealOptionsCarousel extends StatefulWidget {
  final List<MealOption> mealOptions;

  const MealOptionsCarousel({Key? key, required this.mealOptions})
      : super(key: key);

  @override
  _MealOptionsCarouselState createState() => _MealOptionsCarouselState();
}

class _MealOptionsCarouselState extends State<MealOptionsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Meal'),
      ),
      body: CarouselSlider.builder(
        itemCount: widget.mealOptions.length,
        itemBuilder: (context, index, realIndex) {
          final mealOption = widget.mealOptions[index];
          return GestureDetector(
            onTap: () {
              // Call the function to submit the selected meal option
              submitMealSelection(mealOption.name);
            },
            child: MealCard(meal: mealOption),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: false,
        ),
      ),
    );
  }

  Future<void> submitMealSelection(String mealName) async {
    try {
      final recipeDetails = await fetchRecipeDetails(mealName);
      if (recipeDetails.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsPage(
              ingredients: recipeDetails['ingredients'],
              cookingInstructions: recipeDetails['cookingInstructions'],
            ),
          ),
        );
      }
    } catch (e) {
      // Handle error, e.g., show an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Failed to load recipe details. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}

class MealCard extends StatelessWidget {
  final MealOption meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(meal.name),
            subtitle: Text(
                'Cost: ${meal.cost}, Calories: ${meal.calories}, Protein: ${meal.protein}, Time to cook: ${meal.timeToCook}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('SELECT'),
                onPressed: () {/* Handle meal selection */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
