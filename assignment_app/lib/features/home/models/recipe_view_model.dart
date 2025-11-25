class RecipeViewModel {
  final String title;
  final String image;
  final String mealType; // Breakfast, Lunch, etc.
  final int time;
  final int calories;
  final String difficulty;
  final List<String> tags;
  final bool isFavorite;

  RecipeViewModel({
    required this.title,
    required this.image,
    required this.mealType,
    required this.time,
    required this.calories,
    required this.difficulty,
    required this.tags,
    this.isFavorite = false,
  });
}
