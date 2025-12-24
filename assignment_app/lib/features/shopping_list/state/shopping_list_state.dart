import '../models/shopping_item.dart';

class ShoppingListState {
  final List<ShoppingItem> items;

  ShoppingListState({this.items = const []});

  ShoppingListState copyWith({List<ShoppingItem>? items}) {
    return ShoppingListState(items: items ?? this.items);
  }
}
