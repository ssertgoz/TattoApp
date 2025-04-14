import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/tattoo.dart';
import '../repositories/tattoo_repository.dart';

class GenerateTattoo implements UseCase<Tattoo, GenerateTattooParams> {
  final TattooRepository repository;

  GenerateTattoo(this.repository);

  @override
  Future<Either<Failure, Tattoo>> call(GenerateTattooParams params) async {
    return await repository.generateTattoo(
      prompt: params.prompt,
      style: params.style,
      outputLocation: params.outputLocation,
      aspectRatio: params.aspectRatio,
    );
  }
}

class GenerateTattooParams extends Equatable {
  final String prompt;
  final String style;
  final String outputLocation;
  final String aspectRatio;

  const GenerateTattooParams({
    required this.prompt,
    required this.style,
    required this.outputLocation,
    required this.aspectRatio,
  });

  @override
  List<Object> get props => [prompt, style, outputLocation, aspectRatio];
}
