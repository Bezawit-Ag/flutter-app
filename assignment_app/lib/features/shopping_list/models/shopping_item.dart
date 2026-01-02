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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category,
      'isChecked': isChecked,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as String? ?? '1',
      category: json['category'] as String? ?? 'Other',
      isChecked: json['isChecked'] as bool? ?? false,
    );
  }
}
