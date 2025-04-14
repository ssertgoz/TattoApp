part of 'tattoo_generator_bloc.dart';

abstract class TattooGeneratorEvent extends Equatable {
  const TattooGeneratorEvent();

  @override
  List<Object> get props => [];
}

class GenerateTattooEvent extends TattooGeneratorEvent {
  final String prompt;
  final String style;
  final String outputLocation;

  const GenerateTattooEvent({
    required this.prompt,
    required this.style,
    required this.outputLocation,
  });

  @override
  List<Object> get props => [prompt, style, outputLocation];
}
