import 'package:dio/dio.dart';
import '../models/tattoo_model.dart';

abstract class TattooRemoteDataSource {
  Future<TattooModel> generateTattoo({
    required String prompt,
    required String style,
    required String outputLocation,
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
  }) async {
    // TODO: Replace with actual API call
    // For now, return mock data
    return TattooModel(
      imageUrl: 'https://picsum.photos/200/300',
      prompt: prompt,
      style: style,
      outputLocation: outputLocation,
    );
  }
}
