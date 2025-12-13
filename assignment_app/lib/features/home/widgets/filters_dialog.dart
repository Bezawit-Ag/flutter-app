import 'package:flutter/material.dart';

class FiltersDialog extends StatelessWidget {
  final String? selectedMealType;
  final String? selectedDifficulty;
  final Function(String?) onMealTypeSelected;
  final Function(String?) onDifficultySelected;

  const FiltersDialog({
    super.key,
    required this.selectedMealType,
    required this.selectedDifficulty,
    required this.onMealTypeSelected,
    required this.onDifficultySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF151827),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Meal Type Filter
            const Text(
              'Meal Type',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                  .map((type) => FilterChip(
                        label: Text(type),
                        selected: selectedMealType == type,
                        onSelected: (selected) {
                          onMealTypeSelected(selected ? type : null);
                        },
                        selectedColor: const Color(0xFFFF9800).withOpacity(0.3),
                        checkmarkColor: const Color(0xFFFF9800),
                        labelStyle: TextStyle(
                          color: selectedMealType == type
                              ? const Color(0xFFFF9800)
                              : Colors.white70,
                          fontWeight: selectedMealType == type
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: selectedMealType == type
                              ? const Color(0xFFFF9800)
                              : Colors.white30,
                        ),
                        backgroundColor: Colors.white.withOpacity(0.05),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Difficulty Filter
            const Text(
              'Difficulty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['Easy', 'Medium', 'Hard']
                  .map((difficulty) => FilterChip(
                        label: Text(difficulty),
                        selected: selectedDifficulty == difficulty,
                        onSelected: (selected) {
                          onDifficultySelected(selected ? difficulty : null);
                        },
                        selectedColor: _getDifficultyColor(difficulty).withOpacity(0.3),
                        checkmarkColor: _getDifficultyColor(difficulty),
                        labelStyle: TextStyle(
                          color: selectedDifficulty == difficulty
                              ? _getDifficultyColor(difficulty)
                              : Colors.white70,
                          fontWeight: selectedDifficulty == difficulty
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: selectedDifficulty == difficulty
                              ? _getDifficultyColor(difficulty)
                              : Colors.white30,
                        ),
                        backgroundColor: Colors.white.withOpacity(0.05),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

