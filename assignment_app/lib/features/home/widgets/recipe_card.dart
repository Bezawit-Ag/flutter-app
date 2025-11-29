import 'package:flutter/material.dart';
import '../models/recipe_view_model.dart';

class RecipeCard extends StatelessWidget {
  final RecipeViewModel recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF202233),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              recipe.image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    recipe.mealType,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 8),
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
