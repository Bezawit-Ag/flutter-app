class ShoppingItem {
  final String id;
  final String name;
  final String quantity;
  final String category;
  final bool isChecked;

  ShoppingItem({
    required this.id,
    required this.name,
    this.quantity = '1',
    this.category = 'Other',
    this.isChecked = false,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    String? quantity,
    String? category,
    bool? isChecked,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
