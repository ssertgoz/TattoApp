import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../models/tattoo_model.dart';

abstract class TattooRemoteDataSource {
  Future<TattooModel> generateTattoo({
    required String prompt,
    required String style,
    required String outputLocation,
    required String aspectRatio,
  });

  Future<bool> saveTattooToGallery(String imageUrl);
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

  @override
  Future<bool> saveTattooToGallery(String imageUrl) async {
    try {
      print('Downloading image from: $imageUrl');
      // Download the image
      final response = await dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.data == null) {
        print('Error: Downloaded image data is null');
        return false;
      }

      // Save to gallery
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: 'tattoo_${DateTime.now().millisecondsSinceEpoch}',
        isReturnImagePathOfIOS: true
      );

      print('Save result: $result');
      
      // Check if save was successful
      if (result != null && result is Map) {
        // For Android, check isSuccess
        if (result.containsKey('isSuccess')) {
          return result['isSuccess'] == true;
        }
        // For iOS, check if we got a file path
        if (result.containsKey('filePath')) {
          return result['filePath'] != null;
        }
      }
      
      return false;
    } catch (e, stack) {
      print('Error saving image: $e');
      print('Stack trace: $stack');
      return false;
    }
  }
}
