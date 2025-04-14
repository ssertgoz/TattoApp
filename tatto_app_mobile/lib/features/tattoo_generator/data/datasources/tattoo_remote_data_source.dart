import 'package:dio/dio.dart';
import '../models/tattoo_model.dart';

abstract class TattooRemoteDataSource {
  Future<TattooModel> generateTattoo({
    required String prompt,
    required String style,
    required String outputLocation,
    required String aspectRatio,
  });
}

class TattooRemoteDataSourceImpl implements TattooRemoteDataSource {
  final Dio dio;

  TattooRemoteDataSourceImpl({required this.dio});

  @override
  Future<TattooModel> generateTattoo({
    required String prompt,
    required String style,
    required String outputLocation,
    required String aspectRatio,
  }) async {
    // TODO: Replace with actual API call
    // For now, return mock data after a delay
    await Future.delayed(const Duration(seconds: 2));
    
    return TattooModel(
      imageUrl: 'https://picsum.photos/500',
      prompt: prompt,
      style: style,
      outputLocation: outputLocation,
      aspectRatio: aspectRatio,
    );
  }
}
