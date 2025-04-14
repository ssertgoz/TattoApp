import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tattoo_generator_bloc.dart';
import '../widgets/style_selector.dart';
import '../widgets/output_location_selector.dart';

class TattooGeneratorPage extends StatefulWidget {
  const TattooGeneratorPage({super.key});

  @override
  State<TattooGeneratorPage> createState() => _TattooGeneratorPageState();
}

class _TattooGeneratorPageState extends State<TattooGeneratorPage> {
  final _promptController = TextEditingController();
  String _selectedStyle = 'Blackwork';
  String _selectedLocation = 'Leg';

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _generateTattoo() {
    context.read<TattooGeneratorBloc>().add(
          GenerateTattooEvent(
            prompt: _promptController.text,
            style: _selectedStyle,
            outputLocation: _selectedLocation,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tattoo Generator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'Enter your tattoo description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            StyleSelector(
              selectedStyle: _selectedStyle,
              onStyleSelected: (style) {
                setState(() => _selectedStyle = style);
              },
            ),
            const SizedBox(height: 16),
            OutputLocationSelector(
              selectedLocation: _selectedLocation,
              onLocationSelected: (location) {
                setState(() => _selectedLocation = location);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _generateTattoo,
              child: const Text('Generate Tattoo'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<TattooGeneratorBloc, TattooGeneratorState>(
                builder: (context, state) {
                  if (state is TattooGeneratorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TattooGeneratorSuccess) {
                    return Image.network(
                      state.tattoo.imageUrl,
                      fit: BoxFit.contain,
                    );
                  } else if (state is TattooGeneratorError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('Enter a prompt and generate your tattoo'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
