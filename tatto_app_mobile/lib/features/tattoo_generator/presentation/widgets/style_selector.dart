import 'package:flutter/material.dart';

class StyleSelector extends StatelessWidget {
  final String selectedStyle;
  final Function(String) onStyleSelected;

  const StyleSelector({
    super.key,
    required this.selectedStyle,
    required this.onStyleSelected,
  });

  static const styles = ['Blackwork', 'Geometric', 'Minimalist'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Select Style',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: styles.map((style) {
            return ChoiceChip(
              label: Text(style),
              selected: selectedStyle == style,
              onSelected: (selected) {
                if (selected) {
                  onStyleSelected(style);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
