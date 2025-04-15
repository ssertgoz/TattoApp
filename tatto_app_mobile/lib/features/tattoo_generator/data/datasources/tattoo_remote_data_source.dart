import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:tatto_app_mobile/core/config/api_config.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import 'package:tatto_app_mobile/core/error/exceptions.dart';
import '../models/tattoo_model.dart';
import '../models/tattoo_response.dart';
import '../models/tattoo_request.dart';

abstract class TattooRemoteDataSource {
  Future<TattooModel> generateTattoo({
    required String prompt,
    required TattooStyle style,
    required OutputLocation outputLocation,
    required ImageAspectRatio aspectRatio,
  });

  Future<bool> saveTattooToGallery(String imageUrl);
}

class TattooRemoteDataSourceImpl implements TattooRemoteDataSource {
  final Dio dio;

  TattooRemoteDataSourceImpl({required this.dio});

  @override
  Future<TattooModel> generateTattoo({
    required String prompt,
    required TattooStyle style,
    required OutputLocation outputLocation,
    required ImageAspectRatio aspectRatio,
  }) async {
    try {
      final request = TattooRequest(
        prompt: prompt,
        style: style,
        outputLocation: outputLocation,
        aspectRatio: aspectRatio,
      );

      final response = await dio.post(
        '${ApiConfig.baseUrl}${ApiConfig.generateEndpoint}',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final tattooResponse = TattooResponse.fromJson(response.data);
        return TattooModel(
          imageUrl: tattooResponse.imageUrl,
          prompt: prompt,
          style: style.name,
          outputLocation: outputLocation.name,
          aspectRatio: aspectRatio.name,
        );
      } else {
        throw ServerException('Failed to generate tattoo: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Failed to generate tattoo: $e');
    }
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
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
          quality: 100,
          name: 'tattoo_${DateTime.now().millisecondsSinceEpoch}',
          isReturnImagePathOfIOS: true);

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
