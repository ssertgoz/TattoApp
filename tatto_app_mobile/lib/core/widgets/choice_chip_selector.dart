import 'package:flutter/material.dart';

class ChoiceChipSelector extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionSelected;
  final String? label;

  const ChoiceChipSelector({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(option),
                  selected: selectedOption == option,
                  showCheckmark: false,
                  onSelected: (selected) {
                    if (selected) {
                      onOptionSelected(option);
                    }
                  },
                  selectedColor: const Color(0xFFFF4B55),
                  backgroundColor: Colors.white10,
                  labelStyle: TextStyle(
                    color: selectedOption == option ? Colors.white : Colors.grey,
                    fontWeight: selectedOption == option ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
