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
  final int protein; // grams
  final int carbs; // grams
  final int fat; // grams

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
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
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
    int? protein,
    int? carbs,
    int? fat,
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
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'mealType': mealType,
      'time': time,
      'calories': calories,
      'difficulty': difficulty,
      'tags': tags,
      'isFavorite': isFavorite,
      'ingredients': ingredients,
      'instructions': instructions,
      'servings': servings,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }

  factory RecipeViewModel.fromJson(Map<String, dynamic> json) {
    return RecipeViewModel(
      title: json['title'] as String,
      image: json['image'] as String,
      mealType: json['mealType'] as String,
      time: json['time'] as int,
      calories: json['calories'] as int,
      difficulty: json['difficulty'] as String,
      tags: List<String>.from(json['tags'] as List),
      isFavorite: json['isFavorite'] as bool? ?? false,
      ingredients: List<String>.from(json['ingredients'] as List? ?? []),
      instructions: List<String>.from(json['instructions'] as List? ?? []),
      servings: json['servings'] as int? ?? 2,
      protein: json['protein'] as int? ?? 0,
      carbs: json['carbs'] as int? ?? 0,
      fat: json['fat'] as int? ?? 0,
    );
  }
}
