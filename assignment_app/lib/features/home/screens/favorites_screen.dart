import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/home_controller.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: Colors.black, 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Favorites',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: controller.favoriteRecipes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No favorites yet',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap the heart icon on recipes to save them',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                      children: [
                        Text(
                          '${controller.favoriteRecipes.length} Favorite${controller.favoriteRecipes.length == 1 ? '' : 's'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ...controller.favoriteRecipes.map(
                          (recipe) => Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: RecipeCard(recipe: recipe),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

