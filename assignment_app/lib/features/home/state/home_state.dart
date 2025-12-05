import '../models/filter_settings.dart';
import '../models/recipe_view_model.dart';
import '../models/planned_meal.dart';

class HomeState {
  final List<RecipeViewModel> allRecipes;
  final List<RecipeViewModel> visibleRecipes;
  final FilterSettings filters;
  final List<PlannedMeal> plannedMeals;

  HomeState({
    required this.allRecipes,
    required this.visibleRecipes,
    required this.filters,
    this.plannedMeals = const [],
  });

  HomeState copyWith({
    List<RecipeViewModel>? allRecipes,
    List<RecipeViewModel>? visibleRecipes,
    FilterSettings? filters,
    List<PlannedMeal>? plannedMeals,
  }) {
    return HomeState(
      allRecipes: allRecipes ?? this.allRecipes,
      visibleRecipes: visibleRecipes ?? this.visibleRecipes,
      filters: filters ?? this.filters,
      plannedMeals: plannedMeals ?? this.plannedMeals,
    );
  }
}
