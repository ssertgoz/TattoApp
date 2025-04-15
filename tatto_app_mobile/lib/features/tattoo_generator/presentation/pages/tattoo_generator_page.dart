import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import 'package:tatto_app_mobile/core/widgets/choice_chip_selector.dart';

import '../bloc/tattoo_generator/index.dart';
import 'tattoo_generating_page.dart';
import '../../../../main.dart';

class TattooGeneratorPage extends StatefulWidget {
  const TattooGeneratorPage({super.key});

  @override
  State<TattooGeneratorPage> createState() => _TattooGeneratorPageState();
}

class _TattooGeneratorPageState extends State<TattooGeneratorPage> {
  final _promptController = TextEditingController();
  String _selectedStyle = AppConstants.styles.first;
  String _selectedLocation = AppConstants.outputLocations.first;
  String _selectedAspectRatio = AppConstants.aspectRatios.first;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _generateTattoo() {
    if (_promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a description'),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }

    final bloc = context.read<TattooGeneratorBloc>();

    bloc.add(
      GenerateTattooEvent(
        prompt: _promptController.text,
        style: _selectedStyle,
        outputLocation: _selectedLocation,
        aspectRatio: _selectedAspectRatio,
      ),
    );

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => TattooGeneratingPage(
          prompt: _promptController.text,
          style: _selectedStyle,
          outputLocation: _selectedLocation,
          aspectRatio: _selectedAspectRatio,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: const Text(
          'Tattoo Generator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _promptController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your tattoo description',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: _promptController.text.isNotEmpty
                        ? IconButton(
                            icon:
                                const Icon(Icons.close, color: Colors.white54),
                            onPressed: () {
                              setState(() {
                                _promptController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  maxLines: 3,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(height: 24),
              ChoiceChipSelector(
                label: 'Style',
                options: AppConstants.styles,
                selectedOption: _selectedStyle,
                onOptionSelected: (style) {
                  setState(() => _selectedStyle = style);
                },
              ),
              const SizedBox(height: 24),
              ChoiceChipSelector(
                label: 'Output Location',
                options: AppConstants.outputLocations,
                selectedOption: _selectedLocation,
                onOptionSelected: (location) {
                  setState(() => _selectedLocation = location);
                },
              ),
              const SizedBox(height: 24),
              ChoiceChipSelector(
                label: 'Aspect Ratio',
                options: AppConstants.aspectRatios,
                selectedOption: _selectedAspectRatio,
                onOptionSelected: (ratio) {
                  setState(() => _selectedAspectRatio = ratio);
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  minimumSize: const Size(double.infinity, 48),
                  disabledBackgroundColor: Colors.grey,
                ),
                onPressed: _promptController.text.trim().isEmpty
                    ? null
                    : _generateTattoo,
                child: const Text(
                  'Generate',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
