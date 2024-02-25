import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'class.dart';

String cleanJson(String responseBody) {
  String cleanResponse = responseBody
      .replaceFirst('```json', '') // Remove the leading characters
      .replaceFirst('```', ''); // Remove the trailing characters
  return cleanResponse;
}

Future<Map<String, dynamic>> fetchRecipeDetails(String mealName) async {
  final url = Uri.parse(
      'http://10.0.2.2:5001/gdsc-2024-utd-openarms/us-central1/getRecipe');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'mealName': mealName}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(cleanJson(response.body));
    List<String> ingredients = List<String>.from(data['ingredients']);
    List<String> cookingInstructions =
        List<String>.from(data['cookingInstructions']);
    return {
      'ingredients': ingredients,
      'cookingInstructions': cookingInstructions,
    };
  } else {
    throw Exception('Failed to load recipe details');
  }
}

Future<List<MealOption>> sendMealPreferences({
  required String protein,
  required double budget,
  required int peopleToFeed,
  required bool hasFridge,
  required bool hasStove,
}) async {
  final url = Uri.parse(
      'http://10.0.2.2:5001/gdsc-2024-utd-openarms/us-central1/prompt');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'protein': protein,
      'budget': budget,
      'peopleToFeed': peopleToFeed,
      'hasFridge': hasFridge,
      'hasStove': hasStove,
    }),
  );

  if (response.statusCode == 200) {
    // Successfully sent preferences and received response
    final data = json.decode(cleanJson(response.body));
    if (kDebugMode) {
      print(data);
      print("hi");
      print(data["mealOptions"]);
    }
    if (data['mealOptions'] != null) {
      List<MealOption> mealOptions = (data['mealOptions'] as List<dynamic>)
          .map((e) => MealOption.fromJson(e as Map<String, dynamic>))
          .toList();

      return mealOptions;
    } else {
      // Handle the case where 'mealOptions' is not in the response
      print('Meal options not found in the response');
      return [];
    }
  } else {
    // Handle error
    print('Failed to load suggestions');
    return [];
  }
}
