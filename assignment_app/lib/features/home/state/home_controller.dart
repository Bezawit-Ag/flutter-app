import 'package:flutter/material.dart';
import 'home_state.dart';
import '../models/recipe_view_model.dart';
import '../models/filter_settings.dart';
import '../models/planned_meal.dart';

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
        servings: 2,
        ingredients: [
          '2 slices of whole grain bread',
          '1 ripe avocado',
          '2 eggs',
          '1 tbsp lemon juice',
          'Salt and pepper to taste',
          'Red pepper flakes (optional)',
          'Fresh chives for garnish',
        ],
        instructions: [
          'Bring a pot of water to a gentle boil. Add a splash of vinegar.',
          'While water heats, toast the bread slices until golden brown.',
          'Mash the avocado with lemon juice, salt, and pepper in a bowl.',
          'Poach the eggs in the boiling water for 3-4 minutes until whites are set.',
          'Spread the mashed avocado evenly on the toasted bread.',
          'Carefully place a poached egg on each toast.',
          'Garnish with red pepper flakes and fresh chives. Serve immediately.',
        ],
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
        servings: 2,
        ingredients: [
          '2 boneless chicken breasts',
          '1 large head of romaine lettuce',
          '1/2 cup Caesar dressing',
          '1/4 cup grated Parmesan cheese',
          '1 cup croutons',
          '2 cloves garlic, minced',
          'Olive oil for grilling',
          'Salt and black pepper',
        ],
        instructions: [
          'Preheat grill or grill pan to medium-high heat.',
          'Season chicken breasts with salt, pepper, and minced garlic.',
          'Grill chicken for 6-7 minutes per side until cooked through.',
          'Let chicken rest for 5 minutes, then slice into strips.',
          'Wash and chop romaine lettuce into bite-sized pieces.',
          'Toss lettuce with Caesar dressing in a large bowl.',
          'Top with grilled chicken, croutons, and Parmesan cheese.',
          'Serve immediately with additional dressing on the side.',
        ],
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

  void addMealToPlan(RecipeViewModel recipe, DateTime date, String mealType) {
    final plannedMeal = PlannedMeal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      recipe: recipe,
      date: date,
      mealType: mealType,
    );
    final updatedMeals = [...state.plannedMeals, plannedMeal];
    state = state.copyWith(plannedMeals: updatedMeals);
    notifyListeners();
  }

  void removeMealFromPlan(String mealId) {
    final updatedMeals = state.plannedMeals.where((m) => m.id != mealId).toList();
    state = state.copyWith(plannedMeals: updatedMeals);
    notifyListeners();
  }

  List<PlannedMeal> get upcomingMeals {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return state.plannedMeals
        .where((meal) => meal.date.isAfter(today.subtract(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  int get plannedMealsCount => state.plannedMeals.length;
}
