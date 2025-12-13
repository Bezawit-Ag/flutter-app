class RecipeViewModel {
  final String title;
  final String image;
  final String mealType; // Breakfast, Lunch, etc.
  final int time;
  final int calories;
  final String difficulty;
  final List<String> tags;
  final bool isFavorite;
  final List<String> ingredients;
  final List<String> instructions;
  final int servings;

  RecipeViewModel({
    required this.title,
    required this.image,
    required this.mealType,
    required this.time,
    required this.calories,
    required this.difficulty,
    required this.tags,
    this.isFavorite = false,
    this.ingredients = const [],
    this.instructions = const [],
    this.servings = 2,
  });

  RecipeViewModel copyWith({
    String? title,
    String? image,
    String? mealType,
    int? time,
    int? calories,
    String? difficulty,
    List<String>? tags,
    bool? isFavorite,
    List<String>? ingredients,
    List<String>? instructions,
    int? servings,
  }) {
    return RecipeViewModel(
      title: title ?? this.title,
      image: image ?? this.image,
      mealType: mealType ?? this.mealType,
      time: time ?? this.time,
      calories: calories ?? this.calories,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      servings: servings ?? this.servings,
    );
  }
}
