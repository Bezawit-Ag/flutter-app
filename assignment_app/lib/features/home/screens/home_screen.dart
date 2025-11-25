import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/home_controller.dart';           
import '../widgets/search_bar.dart';       

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RecipeSearchBar(
              onChanged: (value) => controller.updateSearch(value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: controller.state.visibleRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = controller.state.visibleRecipes[index];
                  return Card(
                    color: const Color(0xFF2A2A3D),
                    child: ListTile(
                      leading: Image.asset(recipe.image, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(recipe.title),
                      subtitle: Text('${recipe.mealType} • ${recipe.time} min • ${recipe.calories} cal'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
