import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/home_controller.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/filter_chip_set.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFF050816), 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
              decoration: const BoxDecoration(
                color: Color(0xFF0A0A0A),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Recipe Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Discover delicious meals',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RecipeSearchBar(
                    onChanged: controller.updateSearch,
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                children: [
                  Text(
                    '${controller.state.visibleRecipes.length} Recipes',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (controller.availableTags.isNotEmpty) ...[
                    FilterChipSet(
                      tags: controller.availableTags,
                      selected: controller.state.filters.selectedTags,
                      onChanged: controller.updateTags,
                    ),
                    const SizedBox(height: 18),
                  ],
                  ...controller.state.visibleRecipes.map(
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
