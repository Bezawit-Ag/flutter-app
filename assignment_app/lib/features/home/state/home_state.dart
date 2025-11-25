import '../models/filter_settings.dart';
import '../models/recipe_view_model.dart';

class HomeState {
  final List<RecipeViewModel> allRecipes;
  final List<RecipeViewModel> visibleRecipes;
  final FilterSettings filters;

  HomeState({
    required this.allRecipes,
    required this.visibleRecipes,
    required this.filters,
  });

  HomeState copyWith({
    List<RecipeViewModel>? allRecipes,
    List<RecipeViewModel>? visibleRecipes,
    FilterSettings? filters,
  }) {
    return HomeState(
      allRecipes: allRecipes ?? this.allRecipes,
      visibleRecipes: visibleRecipes ?? this.visibleRecipes,
      filters: filters ?? this.filters,
    );
  }
}
