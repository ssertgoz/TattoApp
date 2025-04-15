import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tattoo_generator/index.dart';
import 'tattoo_result_page.dart';
import '../../../../main.dart';

class TattooGeneratingPage extends StatelessWidget {
  const TattooGeneratingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => navigatorKey.currentState?.pop(),
        ),
      ),
      body: BlocConsumer<TattooGeneratorBloc, TattooGeneratorState>(
        listener: (context, state) {
          if (state is TattooGeneratorSuccess) {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(
                builder: (context) => TattooResultPage(tattoo: state.tattoo),
              ),
            );
          } else if (state is TattooGeneratorError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            navigatorKey.currentState?.pop();
          }
        },
        builder: (context, state) {
          if (state is TattooGeneratorError) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(200, 48),
                      ),
                      onPressed: () => navigatorKey.currentState?.pop(),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Generating...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CircularProgressIndicator(
                    color: Color(0xFFFF4B55),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Keep the app open and don\'t lock your device\nas the process may take 10 seconds or more.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () {
                      navigatorKey.currentState?.pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
