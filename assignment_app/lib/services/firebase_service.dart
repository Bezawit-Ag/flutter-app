import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../features/home/models/recipe_view_model.dart';

class FirebaseService {
  DatabaseReference get _database {
    try {
      return FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: 'https://recipe-app-6fea3-default-rtdb.firebaseio.com/',
      ).ref();
    } catch (e) {
      return FirebaseDatabase.instance.ref();
    }
  }

  Future<void> saveRecipe(RecipeViewModel recipe) async {
    try {
      final recipeData = {
        'title': recipe.title,
        'image': recipe.image,
        'mealType': recipe.mealType,
        'time': recipe.time,
        'calories': recipe.calories,
        'difficulty': recipe.difficulty,
        'tags': recipe.tags,
        'ingredients': recipe.ingredients,
        'instructions': recipe.instructions,
        'servings': recipe.servings,
        'protein': recipe.protein,
        'carbs': recipe.carbs,
        'fat': recipe.fat,
        'isFavorite': recipe.isFavorite,
        'createdAt': DateTime.now().toIso8601String(),
      };

      final newRecipeRef = _database.child('recipes').push();
      await newRecipeRef.set(recipeData);
    } catch (e) {
      debugPrint('Error saving recipe: $e');
      rethrow;
    }
  }

  Future<List<RecipeViewModel>> loadRecipes() async {
    try {
      final snapshot = await _database.child('recipes').get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final recipes = <RecipeViewModel>[];

        data.forEach((key, value) {
          try {
            final recipeData = value as Map<dynamic, dynamic>;
            final recipe = RecipeViewModel(
              title: recipeData['title'] ?? '',
              image: recipeData['image'] ?? '',
              mealType: recipeData['mealType'] ?? 'Breakfast',
              time: recipeData['time'] ?? 0,
              calories: recipeData['calories'] ?? 0,
              difficulty: recipeData['difficulty'] ?? 'Easy',
              tags: List<String>.from(recipeData['tags'] ?? []),
              ingredients: List<String>.from(recipeData['ingredients'] ?? []),
              instructions: List<String>.from(recipeData['instructions'] ?? []),
              servings: recipeData['servings'] ?? 2,
              protein: recipeData['protein'] ?? 0,
              carbs: recipeData['carbs'] ?? 0,
              fat: recipeData['fat'] ?? 0,
              isFavorite: recipeData['isFavorite'] ?? false,
            );
            recipes.add(recipe);
          } catch (e) {
            debugPrint('Error parsing recipe: $e');
          }
        });

        return recipes;
      }
      return [];
    } catch (e) {
      debugPrint('Error loading recipes: $e');
      return [];
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _database.child('recipes').child(recipeId).remove();
    } catch (e) {
      debugPrint('Error deleting recipe: $e');
      rethrow;
    }
  }

  Stream<DatabaseEvent> getRecipesStream() {
    return _database.child('recipes').onValue;
  }

  Future<String> encodeImageBytesToBase64(Uint8List bytes) async {
    try {
      final base64String = base64Encode(bytes);
      return 'data:image/jpeg;base64,$base64String';
    } catch (e) {
      debugPrint('Error encoding image: $e');
      return '';
    }
  }

  String decodeBase64ToImageUrl(String base64String) {
    return base64String;
  }
}
