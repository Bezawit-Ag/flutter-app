import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/home_controller.dart';
import '../models/recipe_view_model.dart';
import '../widgets/planned_meal_card.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({super.key});

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
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Meal Planner',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (controller.plannedMealsCount > 0)
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Shopping list generated!'),
                                backgroundColor: Color(0xFF6366F1),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Generate List',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${controller.plannedMealsCount} meals planned',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showAddMealDialog(context, controller),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Add Meal to Plan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: controller.upcomingMeals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 80,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'No meals planned yet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start planning your meals for the week ahead',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      children: [
                        const Text(
                          'Upcoming Meals',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...controller.upcomingMeals.map(
                          (meal) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PlannedMealCard(meal: meal),
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

  void _showAddMealDialog(BuildContext context, HomeController controller) {
    DateTime selectedDate = DateTime.now();
    String? selectedMealType;
    RecipeViewModel? selectedRecipe;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF151827),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Add Meal to Plan',
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Recipe',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<RecipeViewModel>(
                      value: selectedRecipe,
                      isExpanded: true,
                      dropdownColor: const Color(0xFF1F2937),
                      style: const TextStyle(color: Colors.white),
                      hint: const Text(
                        'Choose a recipe',
                        style: TextStyle(color: Colors.white54),
                      ),
                      underline: Container(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      items: controller.state.allRecipes.map((recipe) {
                        return DropdownMenuItem(
                          value: recipe,
                          child: Text(recipe.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRecipe = value;
                          if (value != null) {
                            selectedMealType = value.mealType;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Date',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        builder: (context, child) => Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFFFF9800),
                              onPrimary: Colors.white,
                              surface: Color(0xFF151827),
                              onSurface: Colors.white,
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white54,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Meal Type',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: selectedMealType,
                      isExpanded: true,
                      dropdownColor: const Color(0xFF1F2937),
                      style: const TextStyle(color: Colors.white),
                      hint: const Text(
                        'Select meal type',
                        style: TextStyle(color: Colors.white54),
                      ),
                      underline: Container(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                          .map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMealType = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              onPressed: selectedRecipe != null && selectedMealType != null
                  ? () {
                      controller.addMealToPlan(
                        selectedRecipe!,
                        selectedDate,
                        selectedMealType!,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Meal added to plan!'),
                          backgroundColor: Color(0xFF6366F1),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                disabledBackgroundColor: Colors.grey[800],
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

