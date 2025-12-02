import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_view_model.dart';
import '../state/home_controller.dart';

class RecipeCard extends StatelessWidget {
  final RecipeViewModel recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151827),
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
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Image.asset(
                  recipe.image,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
                // Meal type pill
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      recipe.mealType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _iconText(Icons.timer, "${recipe.time} min"),
                    const SizedBox(width: 14),
                    _iconText(Icons.local_fire_department, "${recipe.calories} cal"),
                    const SizedBox(width: 14),
                    _iconText(Icons.bar_chart, recipe.difficulty),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: recipe.tags
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "#$tag",
                              style: const TextStyle(
                                  color: Colors.orangeAccent, fontSize: 12),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent, size: 17),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}
