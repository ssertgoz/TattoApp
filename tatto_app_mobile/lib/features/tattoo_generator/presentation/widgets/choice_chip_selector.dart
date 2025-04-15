import 'package:flutter/material.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';

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
            style: TextStyle(
              color: AppConstants.white,
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
                  label: Text(option[0].toUpperCase() + option.substring(1)),
                  selected: selectedOption == option,
                  showCheckmark: false,
                  onSelected: (selected) {
                    if (selected) {
                      onOptionSelected(option);
                    }
                  },
                  side: BorderSide.none,
                  backgroundColor: AppConstants.grey,
                  selectedColor: AppConstants.primaryColor,
                  labelStyle: TextStyle(
                    color: selectedOption == option
                        ? AppConstants.white
                        : AppConstants.white,
                    fontWeight: selectedOption == option
                        ? FontWeight.bold
                        : FontWeight.normal,
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
