import 'package:flutter/material.dart';

class FilterChipSet extends StatelessWidget {
  final List<String> tags;
  final List<String> selected;
  final Function(List<String>) onChanged;

  const FilterChipSet({
    super.key,
    required this.tags,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        final active = selected.contains(tag);

        return FilterChip(
          label: Text(tag),
          labelStyle: TextStyle(
            color: active ? Colors.white : Colors.orangeAccent,
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
          ),
          selected: active,
          backgroundColor: const Color(0xFF161927),
          selectedColor: const Color(0xFFFF9800),
          checkmarkColor: Colors.white,
          side: BorderSide(
            color: active
                ? Colors.transparent
                : Colors.orangeAccent.withOpacity(0.5),
          ),
          onSelected: (_) {
            final newList = List<String>.from(selected);
            active ? newList.remove(tag) : newList.add(tag);
            onChanged(newList);
          },
        );
      }).toList(),
    );
  }
}
