import '../../domain/entities/tattoo.dart';

class TattooModel extends Tattoo {
  const TattooModel({
    required String imageUrl,
    required String prompt,
    required String style,
    required String outputLocation,
    required String aspectRatio,
  }) : super(
          imageUrl: imageUrl,
          prompt: prompt,
          style: style,
          outputLocation: outputLocation,
          aspectRatio: aspectRatio,
        );

  factory TattooModel.fromJson(Map<String, dynamic> json) {
    return TattooModel(
      imageUrl: json['imageUrl'] as String,
      prompt: json['prompt'] as String,
      style: json['style'] as String,
      outputLocation: json['outputLocation'] as String,
      aspectRatio: json['aspectRatio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'prompt': prompt,
      'style': style,
      'outputLocation': outputLocation,
      'aspectRatio': aspectRatio,
    };
  }
}
