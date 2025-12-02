import 'package:flutter/material.dart';
import 'home_state.dart';
import '../models/recipe_view_model.dart';
import '../models/filter_settings.dart';

class HomeController extends ChangeNotifier {
  HomeState state = HomeState(
    allRecipes: [],
    visibleRecipes: [],
    filters: FilterSettings(),
  );

  HomeController() {
    _loadRecipes();
  }

  List<String> get availableTags {
    final set = <String>{};
    for (final recipe in state.allRecipes) {
      set.addAll(recipe.tags);
    }
    return set.toList()..sort();
  }

  void _loadRecipes() {
    final sample = [
      RecipeViewModel(
        title: 'Avocado Toast with Poached Eggs',
        mealType: 'Breakfast',
        time: 15,
        calories: 320,
        difficulty: 'Easy',
        image: 'assets/images/avocado_toast.jpg',
        tags: ['healthy', 'quick', 'protein'],
        isFavorite: true, 
      ),
      RecipeViewModel(
        title: 'Grilled Chicken Caesar Salad',
        mealType: 'Lunch',
        time: 30,
        calories: 450,
        difficulty: 'Medium',
        image: 'assets/images/caesar_salad.jpg',
        tags: ['salad', 'low-carb', 'protein'],
        isFavorite: false,
      ),
    ];

    state = state.copyWith(
      allRecipes: sample,
      visibleRecipes: sample,
    );

    notifyListeners();
  }

  void updateSearch(String value) {
    state = state.copyWith(
      filters: state.filters.copyWith(searchQuery: value),
    );
    _filterRecipes();
  }

  void updateTags(List<String> tags) {
    state = state.copyWith(
      filters: state.filters.copyWith(selectedTags: tags),
    );
    _filterRecipes();
  }

  void _filterRecipes() {
    final q = state.filters.searchQuery.toLowerCase();
    final tags = state.filters.selectedTags;

    final filtered = state.allRecipes.where((r) {
      final matchQuery = r.title.toLowerCase().contains(q);
      final matchTags = tags.isEmpty || tags.every((t) => r.tags.contains(t));
      return matchQuery && matchTags;
    }).toList();

    state = state.copyWith(visibleRecipes: filtered);
    notifyListeners();
  }

  void toggleFavorite(String recipeTitle) {
    final updatedRecipes = state.allRecipes.map((recipe) {
      if (recipe.title == recipeTitle) {
        return recipe.copyWith(isFavorite: !recipe.isFavorite);
      }
      return recipe;
    }).toList();

    state = state.copyWith(allRecipes: updatedRecipes);
    _filterRecipes(); 
    notifyListeners();
  }

  List<RecipeViewModel> get favoriteRecipes {
    return state.allRecipes.where((recipe) => recipe.isFavorite).toList();
  }
}
