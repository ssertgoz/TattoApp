import 'package:flutter/material.dart';

class OutputLocationSelector extends StatelessWidget {
  final String selectedLocation;
  final Function(String) onLocationSelected;

  const OutputLocationSelector({
    super.key,
    required this.selectedLocation,
    required this.onLocationSelected,
  });

  static const locations = ['Leg', 'Back', 'Whitepaper'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Select Output Location',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: locations.map((location) {
            return ChoiceChip(
              label: Text(location),
              selected: selectedLocation == location,
              onSelected: (selected) {
                if (selected) {
                  onLocationSelected(location);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
