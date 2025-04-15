import 'package:dartz/dartz.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../entities/tattoo.dart';

abstract class TattooRepository {
  Future<Either<Failure, Tattoo>> generateTattoo({
    required String prompt,
    required TattooStyle style,
    required OutputLocation outputLocation,
    required ImageAspectRatio aspectRatio,
  });

  Future<Either<Failure, bool>> saveTattooToGallery(String imageUrl);
}
