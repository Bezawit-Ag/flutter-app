import 'recipe_view_model.dart';

class PlannedMeal {
  final String id;
  final RecipeViewModel recipe;
  final DateTime date;
  final String mealType;

  PlannedMeal({
    required this.id,
    required this.recipe,
    required this.date,
    required this.mealType,
  });

  PlannedMeal copyWith({
    String? id,
    RecipeViewModel? recipe,
    DateTime? date,
    String? mealType,
  }) {
    return PlannedMeal(
      id: id ?? this.id,
      recipe: recipe ?? this.recipe,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipe': recipe.toJson(),
      'date': date.toIso8601String(),
      'mealType': mealType,
    };
  }

  factory PlannedMeal.fromJson(Map<String, dynamic> json) {
    return PlannedMeal(
      id: json['id'] as String,
      recipe: RecipeViewModel.fromJson(json['recipe'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      mealType: json['mealType'] as String,
    );
  }
}

