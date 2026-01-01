import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:assignment_app/features/shopping_list/widgets/ingredient_selection_dialog.dart';
import 'package:assignment_app/features/shopping_list/state/shopping_list_controller.dart';

void main() {
  testWidgets('IngredientSelectionDialog adds selected ingredients', (
    WidgetTester tester,
  ) async {
    final controller = ShoppingListController();
    final ingredients = ['Milk', 'Eggs', 'Bread'];

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: controller,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        IngredientSelectionDialog(ingredients: ingredients),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      ),
    );

    // Open dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify all ingredients are shown
    expect(find.text('Milk'), findsOneWidget);
    expect(find.text('Eggs'), findsOneWidget);
    expect(find.text('Bread'), findsOneWidget);

    // Uncheck 'Eggs'
    await tester.tap(find.text('Eggs'));
    await tester.pump();

    // Tap Add
    await tester.tap(find.text('Add Selected'));
    await tester.pumpAndSettle();

    // Verify items added to controller
    expect(controller.state.items.length, 2);
    expect(controller.state.items.any((i) => i.name == 'Milk'), isTrue);
    expect(controller.state.items.any((i) => i.name == 'Bread'), isTrue);
    expect(controller.state.items.any((i) => i.name == 'Eggs'), isFalse);
  });
}
