import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import '../../../../main.dart';
import '../bloc/tattoo_generator/index.dart';
import '../pages/tattoo_generating_page.dart';

class EditPromptBottomSheet extends StatefulWidget {
  final String initialPrompt;
  final String style;
  final String outputLocation;
  final String aspectRatio;

  const EditPromptBottomSheet({
    super.key,
    required this.initialPrompt,
    required this.style,
    required this.outputLocation,
    required this.aspectRatio,
  });

  @override
  State<EditPromptBottomSheet> createState() => _EditPromptBottomSheetState();
}

class _EditPromptBottomSheetState extends State<EditPromptBottomSheet> {
  late final TextEditingController _promptController;
  bool _isPromptEdited = false;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController(text: widget.initialPrompt);
    _promptController.addListener(_onPromptChanged);
  }

  void _onPromptChanged() {
    setState(() {
      _isPromptEdited = _promptController.text != widget.initialPrompt;
    });
  }

  @override
  void dispose() {
    _promptController.removeListener(_onPromptChanged);
    _promptController.dispose();
    super.dispose();
  }

  void _onEditPressed() {
    final bloc = context.read<TattooGeneratorBloc>();
    bloc.add(
      GenerateTattooEvent(
        prompt: _promptController.text,
        style: TattooStyle.values.firstWhere((s) => s.name == widget.style),
        outputLocation: OutputLocation.values.firstWhere((s) => s.name == widget.outputLocation),
        aspectRatio:
            ImageAspectRatio.values.firstWhere((s) => s.toJsonValue() == widget.aspectRatio),
      ),
    );

    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => TattooGeneratingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      margin: const EdgeInsets.only(top: 16),
      padding: EdgeInsets.fromLTRB(
        16.0,
        16.0,
        16.0,
        MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Edit Prompt',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _promptController,
            maxLength: 200,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF4B55)),
              ),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4B55),
              minimumSize: const Size(double.infinity, 48),
              disabledBackgroundColor: Colors.grey,
            ),
            onPressed: _isPromptEdited ? _onEditPressed : null,
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
