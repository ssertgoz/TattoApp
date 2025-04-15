import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/tattoo.dart';
import '../../domain/repositories/tattoo_repository.dart';
import '../datasources/tattoo_remote_data_source.dart';

class TattooRepositoryImpl implements TattooRepository {
  final TattooRemoteDataSource remoteDataSource;

  TattooRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Tattoo>> generateTattoo({
    required String prompt,
    required String style,
    required String outputLocation,
    required String aspectRatio,
  }) async {
    try {
      final tattoo = await remoteDataSource.generateTattoo(
        prompt: prompt,
        style: style,
        outputLocation: outputLocation,
        aspectRatio: aspectRatio,
      );
      return Right(tattoo);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveTattooToGallery(String imageUrl) async {
    try {
      final result = await remoteDataSource.saveTattooToGallery(imageUrl);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
