import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_view_model.dart';
import '../state/home_controller.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeViewModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int servings = 2;

  @override
  void initState() {
    super.initState();
    servings = widget.recipe.servings;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    final currentRecipe = controller.state.allRecipes
        .firstWhere(
          (r) => r.title == widget.recipe.title,
          orElse: () => widget.recipe,
        );
    
    // Calculate nutrition per serving
    final caloriesPerServing = (currentRecipe.calories / currentRecipe.servings).round();
    final proteinPerServing = (currentRecipe.protein / currentRecipe.servings).round();
    final carbsPerServing = (currentRecipe.carbs / currentRecipe.servings).round();
    final fatPerServing = (currentRecipe.fat / currentRecipe.servings).round();

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
              backgroundColor: Colors.black,
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
              leading: Container(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
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
                    // Servings Control
                    Row(
                      children: [
                        const Text(
                          'Servings',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (servings > 1) {
                                  setState(() {
                                    servings--;
                                  });
                                }
                              },
                              icon: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                '$servings',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  servings++;
                                });
                              },
                              icon: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Nutrition Cards
                    Row(
                      children: [
                        Expanded(
                          child: _NutritionCard(
                            value: '${(caloriesPerServing * servings)}',
                            label: 'Calories',
                            icon: Icons.local_fire_department,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _NutritionCard(
                            value: '${(proteinPerServing * servings)}g',
                            label: 'Protein',
                            icon: Icons.fitness_center,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _NutritionCard(
                            value: '${(carbsPerServing * servings)}g',
                            label: 'Carbs',
                            icon: Icons.grain,
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _NutritionCard(
                            value: '${(fatPerServing * servings)}g',
                            label: 'Fat',
                            icon: Icons.opacity,
                            color: Colors.pink,
                          ),
                        ),
                      ],
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
                          color: const Color(0xFF1A1A1A),
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
                                              const EdgeInsets.only(right: 12, top: 6),
                                          child: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 20,
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

class _NutritionCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _NutritionCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151827),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

