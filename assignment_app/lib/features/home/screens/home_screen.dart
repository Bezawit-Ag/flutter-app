import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/home_controller.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _filtersExpanded = false;

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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RecipeSearchBar(
                          onChanged: controller.updateSearch,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filtersExpanded = !_filtersExpanded;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.filter_list,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Filters',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                _filtersExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expandable Filters
            if (_filtersExpanded)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meal Type Filter
                    const Text(
                      'Meal Type',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _showMealTypePicker(context, controller);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.state.filters.selectedMealType ??
                                  'All',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Difficulty Filter
                    const Text(
                      'Difficulty',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _showDifficultyPicker(context, controller);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.state.filters.selectedDifficulty ??
                                  'All',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: controller.state.visibleRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = controller.state.visibleRecipes[index];
                  return RecipeCard(recipe: recipe);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMealTypePicker(BuildContext context, HomeController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack']
              .map(
                (type) => ListTile(
                  title: Text(
                    type,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    controller.updateMealTypeFilter(
                      type == 'All' ? null : type,
                    );
                    Navigator.pop(context);
                  },
                  trailing:
                      controller.state.filters.selectedMealType == type ||
                          (type == 'All' &&
                              controller.state.filters.selectedMealType == null)
                      ? const Icon(Icons.check, color: Colors.orange)
                      : null,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showDifficultyPicker(BuildContext context, HomeController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['All', 'Easy', 'Medium', 'Hard']
              .map(
                (difficulty) => ListTile(
                  title: Text(
                    difficulty,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    controller.updateDifficultyFilter(
                      difficulty == 'All' ? null : difficulty,
                    );
                    Navigator.pop(context);
                  },
                  trailing:
                      controller.state.filters.selectedDifficulty ==
                              difficulty ||
                          (difficulty == 'All' &&
                              controller.state.filters.selectedDifficulty ==
                                  null)
                      ? const Icon(Icons.check, color: Colors.orange)
                      : null,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
