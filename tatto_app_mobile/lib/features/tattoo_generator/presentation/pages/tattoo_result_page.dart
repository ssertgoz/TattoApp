import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import 'package:tatto_app_mobile/main.dart';
import '../../domain/entities/tattoo.dart';
import '../bloc/image_saver/index.dart';
import '../bloc/tattoo_generator/index.dart';
import '../widgets/edit_prompt_bottom_sheet.dart';
import 'tattoo_generating_page.dart';
import 'tattoo_success_page.dart';

class TattooResultPage extends StatelessWidget {
  final Tattoo tattoo;

  const TattooResultPage({
    super.key,
    required this.tattoo,
  });

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('Error') ? Colors.red : Colors.green,
      ),
    );
  }

  void _showEditPrompt(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      builder: (context) => EditPromptBottomSheet(
        initialPrompt: tattoo.prompt,
        style: tattoo.style,
        outputLocation: tattoo.outputLocation,
        aspectRatio: tattoo.aspectRatio,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageSaverBloc, ImageSaverState>(
      listener: (context, state) {
        if (state is ImageSaverSuccess) {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => const TattooSuccessPage(),
            ),
          );
        } else if (state is ImageSaverError) {
          _showMessage(context, 'Error: ${state.message}');
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => navigatorKey.currentState?.pop(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Image.network(
                tattoo.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        final bloc = context.read<TattooGeneratorBloc>();
                        bloc.add(
                          GenerateTattooEvent(
                            prompt: tattoo.prompt,
                            style: TattooStyle.values.firstWhere((s) => s.name == tattoo.style),
                            outputLocation: OutputLocation.values
                                .firstWhere((s) => s.name == tattoo.outputLocation),
                            aspectRatio: ImageAspectRatio.values
                                .firstWhere((s) => s.toJsonValue() == tattoo.aspectRatio),
                          ),
                        );
                        navigatorKey.currentState?.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => TattooGeneratingPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text('Recreate'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _showEditPrompt(context),
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('Edit'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4B55),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: state is ImageSaverLoading
                      ? null
                      : () {
                          context.read<ImageSaverBloc>().add(
                                SaveImageEvent(imageUrl: tattoo.imageUrl),
                              );
                        },
                  icon: state is ImageSaverLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save_alt, color: Colors.white),
                  label: Text(
                    state is ImageSaverLoading ? 'Saving...' : 'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
