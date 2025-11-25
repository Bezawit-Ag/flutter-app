class FilterSettings {
  final String searchQuery;
  final List<String> selectedTags;

  FilterSettings({
    this.searchQuery = '',
    this.selectedTags = const [],
  });

  FilterSettings copyWith({
    String? searchQuery,
    List<String>? selectedTags,
  }) {
    return FilterSettings(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
    );
  }
}
