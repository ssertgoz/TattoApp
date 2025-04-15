import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tattoo_generator/index.dart';
import 'tattoo_result_page.dart';
import '../../../../main.dart';

class TattooGeneratingPage extends StatelessWidget {
  final String prompt;
  final String style;
  final String outputLocation;
  final String aspectRatio;

  const TattooGeneratingPage({
    super.key,
    required this.prompt,
    required this.style,
    required this.outputLocation,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            return const SizedBox.shrink();
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
