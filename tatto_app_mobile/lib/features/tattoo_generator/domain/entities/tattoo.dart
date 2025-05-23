import 'package:equatable/equatable.dart';

class Tattoo extends Equatable {
  final String imageUrl;
  final String prompt;
  final String style;
  final String outputLocation;
  final String aspectRatio;

  const Tattoo({
    required this.imageUrl,
    required this.prompt,
    required this.style,
    required this.outputLocation,
    required this.aspectRatio,
  });

  @override
  List<Object> get props => [imageUrl, prompt, style, outputLocation, aspectRatio];
}
