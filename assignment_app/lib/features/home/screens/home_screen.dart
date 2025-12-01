import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/home_controller.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1A),  // dark purple background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6E4E), Color(0xFFFF3E7F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),//color change 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recipe Hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
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

          // Recipes list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.state.visibleRecipes.length,
              itemBuilder: (context, index) {
                final recipe = controller.state.visibleRecipes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RecipeCard(recipe: recipe),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
