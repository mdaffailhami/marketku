import 'package:flutter/material.dart';

class MyChoiceChip extends StatefulWidget {
  const MyChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final Function(bool value) onSelected;

  @override
  State<MyChoiceChip> createState() => _MyChoiceChipState();
}

class _MyChoiceChipState extends State<MyChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: !widget.isSelected
          ? const EdgeInsets.symmetric(horizontal: 4, vertical: 7)
          : null,
      label: Text(widget.label),
      selected: widget.isSelected,
      onSelected: widget.onSelected,
      side: widget.isSelected
          ? BorderSide.none
          : BorderSide(
              width: 0.2,
              color: Theme.of(context).colorScheme.outline,
            ),
    );
  }
}
