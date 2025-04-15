import 'package:equatable/equatable.dart';
import '../../../domain/entities/tattoo.dart';

abstract class TattooGeneratorState extends Equatable {
  const TattooGeneratorState();

  @override
  List<Object> get props => [];
}

class TattooGeneratorInitial extends TattooGeneratorState {}

class TattooGeneratorLoading extends TattooGeneratorState {}

class TattooGeneratorSuccess extends TattooGeneratorState {
  final Tattoo tattoo;

  const TattooGeneratorSuccess(this.tattoo);

  @override
  List<Object> get props => [tattoo];
}

class TattooGeneratorError extends TattooGeneratorState {
  final String message;

  const TattooGeneratorError(this.message);

  @override
  List<Object> get props => [message];
}


