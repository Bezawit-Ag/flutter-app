import 'package:flutter/material.dart';

class RecipeSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const RecipeSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search recipes or ingredients...",
        filled: true,
        fillColor: Colors.white.withAlpha((0.1 * 255).toInt()),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
