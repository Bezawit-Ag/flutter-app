import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_view_model.dart';
import '../state/home_controller.dart';
import '../../shopping_list/state/shopping_list_controller.dart';
import '../../shopping_list/widgets/ingredient_selection_dialog.dart';
import '../screens/recipe_detail_screen.dart';

class RecipeCard extends StatelessWidget {
  final RecipeViewModel recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                _buildRecipeImage(recipe.image),
                // Dark gradient at the bottom of the image
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),
                ),
                // Add to Shopping List icon
                Positioned(
                  top: 10,
                  left: 10,
                  child: Consumer<ShoppingListController>(
                    builder: (context, controller, _) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => IngredientSelectionDialog(
                              ingredients: recipe.ingredients,
                            ),
                          );
                        },
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Meal type pill
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getMealTypeColor(recipe.mealType).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      recipe.mealType.toLowerCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Favorite icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: Consumer<HomeController>(
                    builder: (context, controller, _) {
                      final currentRecipe = controller.state.allRecipes
                          .firstWhere(
                            (r) => r.title == recipe.title,
                            orElse: () => recipe,
                          );
                      return GestureDetector(
                        onTap: () {
                          controller.toggleFavorite(recipe.title);
                        },
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            currentRecipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: currentRecipe.isFavorite
                                ? Colors.redAccent
                                : Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  recipe.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                        fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                  children: [
                    _iconText(Icons.timer, "${recipe.time}m"),
                    _iconText(Icons.person, "${recipe.servings}"),
                    _iconText(Icons.local_fire_department, "${recipe.calories} cal"),
                  ],
                ),
                  const SizedBox(height: 6),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(recipe.difficulty).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _getDifficultyColor(recipe.difficulty),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    recipe.difficulty.toLowerCase(),
                    style: TextStyle(
                      color: _getDifficultyColor(recipe.difficulty),
                        fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildRecipeImage(String imageUrl) {
    if (imageUrl.startsWith('data:image')) {
      final base64String = imageUrl.split(',').last;
      try {
        final imageBytes = base64Decode(base64String);
        return Image.memory(
          imageBytes,
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[800],
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            );
          },
        );
      } catch (e) {
        return Container(
          height: 120,
          width: double.infinity,
          color: Colors.grey[800],
          child: const Icon(Icons.image_not_supported, color: Colors.grey),
        );
      }
    } else if (imageUrl.isNotEmpty) {
      return Image.asset(
        imageUrl,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey[800],
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          );
        },
      );
    } else {
      return Container(
        height: 120,
        width: double.infinity,
        color: Colors.grey[800],
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 3),
        Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getMealTypeColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Colors.green;
      case 'lunch':
        return Colors.lightGreen;
      case 'dinner':
        return Colors.teal;
      case 'snack':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
