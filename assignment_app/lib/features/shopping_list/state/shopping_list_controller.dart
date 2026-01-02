import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'shopping_list_state.dart';
import '../models/shopping_item.dart';

class ShoppingListController extends ChangeNotifier {
  ShoppingListState state = ShoppingListState();
  static const String _shoppingItemsKey = 'shopping_items';

  ShoppingListController() {
    _loadShoppingItems();
  }

  // Getters for UI
  int get checkedCount => state.items.where((i) => i.isChecked).length;
  int get totalCount => state.items.length;
  double get progress => totalCount == 0 ? 0.0 : checkedCount / totalCount;

  Map<String, List<ShoppingItem>> get itemsByCategory {
    final map = <String, List<ShoppingItem>>{};
    for (final item in state.items) {
      if (!map.containsKey(item.category)) {
        map[item.category] = [];
      }
      map[item.category]!.add(item);
    }
    return map;
  }

  void addItem(String name, {String quantity = '1', String category = 'Other'}) {
    final newItem = ShoppingItem(
      id: DateTime.now().millisecondsSinceEpoch.toString() + name, // Simple fix for uniqueness in this context
      name: name,
      quantity: quantity,
      category: category,
    );
    final updatedItems = [...state.items, newItem];
    state = state.copyWith(items: updatedItems);
    _saveShoppingItems();
    notifyListeners();
  }

  void removeItem(String id) {
    final updatedItems = state.items.where((i) => i.id != id).toList();
    state = state.copyWith(items: updatedItems);
    _saveShoppingItems();
    notifyListeners();
  }

  void toggleItem(String id) {
    final updatedItems = state.items.map((item) {
      if (item.id == id) {
        return item.copyWith(isChecked: !item.isChecked);
      }
      return item;
    }).toList();
    state = state.copyWith(items: updatedItems);
    _saveShoppingItems();
    notifyListeners();
  }
  
  void clearChecked() {
    final updatedItems = state.items.where((i) => !i.isChecked).toList();
    state = state.copyWith(items: updatedItems);
    _saveShoppingItems();
    notifyListeners();
  }

  void addIngredientsFromRecipe(List<String> ingredients) {
    final newItems = ingredients.map((ingredient) => ShoppingItem(
      id: DateTime.now().millisecondsSinceEpoch.toString() + ingredient,
      name: ingredient,
      quantity: '1', // Default quantity
      category: 'Other', // Default category
    )).toList();

    final updatedItems = [...state.items, ...newItems];
    state = state.copyWith(items: updatedItems);
    _saveShoppingItems();
    notifyListeners();
  }

  Future<void> _saveShoppingItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final itemsJson = state.items.map((item) => item.toJson()).toList();
      await prefs.setString(_shoppingItemsKey, jsonEncode(itemsJson));
    } catch (e) {
      debugPrint('Error saving shopping items: $e');
    }
  }

  Future<void> _loadShoppingItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final itemsJsonString = prefs.getString(_shoppingItemsKey);
      if (itemsJsonString != null) {
        final List<dynamic> itemsJson = jsonDecode(itemsJsonString);
        final loadedItems = itemsJson
            .map((json) => ShoppingItem.fromJson(json as Map<String, dynamic>))
            .toList();
        state = state.copyWith(items: loadedItems);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading shopping items: $e');
    }
  }
}
