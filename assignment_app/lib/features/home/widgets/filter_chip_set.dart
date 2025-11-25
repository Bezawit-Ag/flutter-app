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
      children: tags.map((tag) {
        final active = selected.contains(tag);

        return FilterChip(
          label: Text(tag),
          selected: active,
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
