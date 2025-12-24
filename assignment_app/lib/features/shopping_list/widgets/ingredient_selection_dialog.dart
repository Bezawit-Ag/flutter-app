import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/shopping_list_controller.dart';

class IngredientSelectionDialog extends StatefulWidget {
  final List<String> ingredients;

  const IngredientSelectionDialog({super.key, required this.ingredients});

  @override
  State<IngredientSelectionDialog> createState() =>
      _IngredientSelectionDialogState();
}

class _IngredientSelectionDialogState extends State<IngredientSelectionDialog> {
  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.filled(widget.ingredients.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Select Ingredients',
        style: TextStyle(color: Colors.white),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.ingredients.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(
                widget.ingredients[index],
                style: const TextStyle(color: Colors.white70),
              ),
              value: _selected[index],
              activeColor: Colors.orange,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  _selected[index] = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            final selectedIngredients = <String>[];
            for (int i = 0; i < widget.ingredients.length; i++) {
              if (_selected[i]) {
                selectedIngredients.add(widget.ingredients[i]);
              }
            }

            if (selectedIngredients.isNotEmpty) {
              context.read<ShoppingListController>().addIngredientsFromRecipe(
                selectedIngredients,
              );

              Navigator.pop(context); // Close dialog

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added ${selectedIngredients.length} items to shopping list',
                  ),
                  backgroundColor: Colors.orange,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Add Selected',
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}
