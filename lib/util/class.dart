class MealOption {
  final String name;
  final String cost;
  final String calories;
  final String protein;
  final String timeToCook;

  MealOption({
    required this.name,
    required this.cost,
    required this.calories,
    required this.protein,
    required this.timeToCook,
  });

  factory MealOption.fromJson(Map<String, dynamic> json) {
    return MealOption(
      name: json['name'],
      cost: json['cost'],
      calories: json['calories'],
      protein: json['protein'],
      timeToCook: json['timeToCook'],
    );
  }
}
