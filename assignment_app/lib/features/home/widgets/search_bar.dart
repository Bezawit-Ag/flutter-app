import 'package:flutter/material.dart';

class RecipeSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const RecipeSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          hintText: "Search recipes or ingredients...",
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 12),
        ),
      ),
    );
  }
}
