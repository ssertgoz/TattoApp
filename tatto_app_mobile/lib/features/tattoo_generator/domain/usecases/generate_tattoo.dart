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
    );
  }
}

class GenerateTattooParams extends Equatable {
  final String prompt;
  final String style;
  final String outputLocation;

  const GenerateTattooParams({
    required this.prompt,
    required this.style,
    required this.outputLocation,
  });

  @override
  List<Object> get props => [prompt, style, outputLocation];
}
