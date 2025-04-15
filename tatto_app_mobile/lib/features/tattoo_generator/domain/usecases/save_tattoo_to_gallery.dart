import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/tattoo_repository.dart';

class SaveTattooToGallery {
  final TattooRepository repository;

  SaveTattooToGallery(this.repository);

  Future<Either<Failure, bool>> call(String imageUrl) {
    return repository.saveTattooToGallery(imageUrl);
  }
}
