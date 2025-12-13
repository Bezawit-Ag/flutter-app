class FilterSettings {
  final String searchQuery;
  final List<String> selectedTags;
  final String? selectedMealType;
  final String? selectedDifficulty;

  FilterSettings({
    this.searchQuery = '',
    this.selectedTags = const [],
    this.selectedMealType,
    this.selectedDifficulty,
  });

  FilterSettings copyWith({
    String? searchQuery,
    List<String>? selectedTags,
    String? selectedMealType,
    String? selectedDifficulty,
  }) {
    return FilterSettings(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
      selectedMealType: selectedMealType ?? this.selectedMealType,
      selectedDifficulty: selectedDifficulty ?? this.selectedDifficulty,
    );
  }
}
