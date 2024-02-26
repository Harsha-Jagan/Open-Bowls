import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/classes/user.dart';
import 'package:frontend/pages/services/database.dart';
import 'package:provider/provider.dart';

import '../classes/userdata.dart';
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
  CustomerData? userProfile;

  Future<void> _fetchUserProfile() async {
    final userProvider = Provider.of<CustomerData>(context);
    print(userProvider.uid);

    setState(() {
      userProfile = userProvider;
    });
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
          } else {
            return const Scaffold();
          }
        });
  }

  Future<void> submitMealSelection(String mealName) async {
    try {
      final recipeDetails = await fetchRecipeDetails(mealName, userProfile);
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
