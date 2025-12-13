import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_view_model.dart';
import '../state/home_controller.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeViewModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    final currentRecipe = controller.state.allRecipes
        .firstWhere(
          (r) => r.title == recipe.title,
          orElse: () => recipe,
        );

    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9800), Color(0xFFFF6F00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9800).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.restaurant_menu, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Ready to cook! Enjoy your meal! 👨‍🍳',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFFFF9800),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'I\'m Ready to Cook!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: const Color(0xFF050816),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      currentRecipe.image,
                      fit: BoxFit.cover,
                    ),
                    // Dark gradient overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Consumer<HomeController>(
                  builder: (context, controller, _) {
                    return IconButton(
                      icon: Icon(
                        currentRecipe.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: currentRecipe.isFavorite
                            ? Colors.redAccent
                            : Colors.white,
                      ),
                      onPressed: () {
                        controller.toggleFavorite(currentRecipe.title);
                      },
                    );
                  },
                ),
              ],
            ),
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Meal Type
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentRecipe.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF9800).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFFF9800),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  currentRecipe.mealType,
                                  style: const TextStyle(
                                    color: Color(0xFFFF9800),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                          icon: Icons.timer,
                          value: "${currentRecipe.time}",
                          label: "Minutes",
                          color: Colors.blueAccent,
                        ),
                        _StatItem(
                          icon: Icons.local_fire_department,
                          value: "${currentRecipe.calories}",
                          label: "Calories",
                          color: Colors.orangeAccent,
                        ),
                        _StatItem(
                          icon: Icons.restaurant,
                          value: "${currentRecipe.servings}",
                          label: "Servings",
                          color: Colors.greenAccent,
                        ),
                        _StatItem(
                          icon: Icons.bar_chart,
                          value: currentRecipe.difficulty,
                          label: "Level",
                          color: Colors.purpleAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: currentRecipe.tags
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 13,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                    // Ingredients Section
                    if (currentRecipe.ingredients.isNotEmpty) ...[
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF151827),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: currentRecipe.ingredients
                              .map((ingredient) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFF9800),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            ingredient,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                    // Instructions Section
                    if (currentRecipe.instructions.isNotEmpty) ...[
                      const Text(
                        'Instructions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...currentRecipe.instructions.asMap().entries.map(
                            (entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF9800),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${entry.key + 1}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                    const SizedBox(height: 100), // Extra space for floating button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

