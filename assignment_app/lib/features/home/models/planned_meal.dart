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
}

