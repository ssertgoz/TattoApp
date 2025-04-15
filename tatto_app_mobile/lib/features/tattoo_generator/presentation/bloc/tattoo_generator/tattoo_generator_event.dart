import 'package:equatable/equatable.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';

abstract class TattooGeneratorEvent extends Equatable {
  const TattooGeneratorEvent();

  @override
  List<Object> get props => [];
}

class GenerateTattooEvent extends TattooGeneratorEvent {
  final String prompt;
  final TattooStyle style;
  final OutputLocation outputLocation;
  final ImageAspectRatio aspectRatio;

  const GenerateTattooEvent({
    required this.prompt,
    required this.style,
    required this.outputLocation,
    required this.aspectRatio,
  });

  @override
  List<Object> get props => [prompt, style, outputLocation, aspectRatio];
}
