import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import 'package:tatto_app_mobile/features/tattoo_generator/presentation/widgets/choice_chip_selector.dart';

import '../../../../main.dart';
import '../bloc/tattoo_generator/index.dart';
import 'tattoo_generating_page.dart';

class TattooGeneratorPage extends StatefulWidget {
  const TattooGeneratorPage({super.key});

  @override
  State<TattooGeneratorPage> createState() => _TattooGeneratorPageState();
}

class _TattooGeneratorPageState extends State<TattooGeneratorPage> {
  final _promptController = TextEditingController();
  TattooStyle _selectedStyle = AppConstants.styles.first;
  OutputLocation _selectedLocation = AppConstants.outputLocations.first;
  ImageAspectRatio _selectedAspectRatio = AppConstants.aspectRatios.first;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _generateTattoo() {
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
        builder: (context) => TattooGeneratingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: Text(
          'Tattoo Generator',
          style: TextStyle(color: AppConstants.white),
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
                  color: AppConstants.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _promptController,
                  style: const TextStyle(color: AppConstants.white),
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
                options: AppConstants.styles.map((s) => s.name).toList(),
                selectedOption: _selectedStyle.name,
                onOptionSelected: (style) {
                  setState(() => _selectedStyle =
                      TattooStyle.values.firstWhere((s) => s.name == style));
                },
              ),
              const SizedBox(height: 24),
              ChoiceChipSelector(
                label: 'Output Location',
                options:
                    AppConstants.outputLocations.map((s) => s.name).toList(),
                selectedOption: _selectedLocation.name,
                onOptionSelected: (location) {
                  setState(() => _selectedLocation = OutputLocation.values
                      .firstWhere((s) => s.name == location));
                },
              ),
              const SizedBox(height: 24),
              ChoiceChipSelector(
                label: 'Aspect Ratio',
                options: AppConstants.aspectRatios.map((s) => s.name).toList(),
                selectedOption: _selectedAspectRatio.name,
                onOptionSelected: (ratio) {
                  setState(() => _selectedAspectRatio = ImageAspectRatio.values
                      .firstWhere((s) => s.name == ratio));
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  minimumSize: const Size(double.infinity, 48),
                  disabledBackgroundColor: AppConstants.disabledColor,
                ),
                onPressed: _promptController.text.trim().isEmpty
                    ? null
                    : _generateTattoo,
                child: const Text(
                  'Generate',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstants.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
