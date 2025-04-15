import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/generate_tattoo.dart';
import 'tattoo_generator_event.dart';
import 'tattoo_generator_state.dart';

class TattooGeneratorBloc extends Bloc<TattooGeneratorEvent, TattooGeneratorState> {
  final GenerateTattoo generateTattoo;
  TattooGeneratorBloc({
    required this.generateTattoo,
  }) : super(TattooGeneratorInitial()) {
    on<GenerateTattooEvent>(_onGenerateTattoo);
  }

  Future<void> _onGenerateTattoo(
    GenerateTattooEvent event,
    Emitter<TattooGeneratorState> emit,
  ) async {
    emit(TattooGeneratorLoading());

    final result = await generateTattoo(
      GenerateTattooParams(
        prompt: event.prompt,
        style: event.style,
        outputLocation: event.outputLocation,
        aspectRatio: event.aspectRatio,
      ),
    );

    result.fold(
      (failure) => emit(TattooGeneratorError(failure.message)),
      (tattoo) => emit(TattooGeneratorSuccess(tattoo)),
    );
  }
}
