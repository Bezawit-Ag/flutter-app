import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_app/features/shopping_list/state/shopping_list_controller.dart';

void main() {
  group('ShoppingListController', () {
    late ShoppingListController controller;

    setUp(() {
      controller = ShoppingListController();
    });

    test('initial state should be empty', () {
      expect(controller.state.items, isEmpty);
      expect(controller.checkedCount, 0);
      expect(controller.totalCount, 0);
      expect(controller.progress, 0.0);
    });

    test('addItem should add item to the list with default values', () {
      controller.addItem('Milk');
      expect(controller.state.items.length, 1);
      final item = controller.state.items.first;
      expect(item.name, 'Milk');
      expect(item.quantity, '1');
      expect(item.category, 'Other');
      expect(item.isChecked, false);
    });

    test('addItem should add item with custom values', () {
      controller.addItem('Eggs', quantity: '12', category: 'Dairy');
      expect(controller.state.items.length, 1);
      final item = controller.state.items.first;
      expect(item.name, 'Eggs');
      expect(item.quantity, '12');
      expect(item.category, 'Dairy');
    });

    test('toggleItem should switch checked state', () {
      controller.addItem('Milk');
      final id = controller.state.items.first.id;

      controller.toggleItem(id);
      expect(controller.state.items.first.isChecked, true);
      expect(controller.checkedCount, 1);
      expect(controller.progress, 1.0);

      controller.toggleItem(id);
      expect(controller.state.items.first.isChecked, false);
      expect(controller.checkedCount, 0);
      expect(controller.progress, 0.0);
    });

    test('removeItem should remove item from the list', () {
      controller.addItem('Milk');
      final id = controller.state.items.first.id;

      controller.removeItem(id);
      expect(controller.state.items, isEmpty);
    });

    test('itemsByCategory should group items correctly', () {
      controller.addItem('Milk', category: 'Dairy');
      controller.addItem('Cheese', category: 'Dairy');
      controller.addItem('Bread', category: 'Bakery');

      final grouped = controller.itemsByCategory;
      expect(grouped.length, 2);
      expect(grouped['Dairy']!.length, 2);
      expect(grouped['Bakery']!.length, 1);
    });

    test('clearChecked should remove only checked items', () {
      controller.addItem('Milk'); // Unchecked
      controller.addItem('Bread'); // Will check
      final breadId = controller.state.items.last.id;
      controller.toggleItem(breadId);

      expect(controller.state.items.length, 2);
      controller.clearChecked();

      expect(controller.state.items.length, 1);
      expect(controller.state.items.first.name, 'Milk');
    });
  });
}
