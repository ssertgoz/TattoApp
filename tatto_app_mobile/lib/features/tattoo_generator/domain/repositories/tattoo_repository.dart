import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/tattoo.dart';

abstract class TattooRepository {
  Future<Either<Failure, Tattoo>> generateTattoo({
    required String prompt,
    required String style,
    required String outputLocation,
    required String aspectRatio,
  });

  Future<Either<Failure, bool>> saveTattooToGallery(String imageUrl);
}
