// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tattoo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TattooRequest _$TattooRequestFromJson(Map<String, dynamic> json) =>
    TattooRequest(
      prompt: json['prompt'] as String,
      style: $enumDecode(_$TattooStyleEnumMap, json['style']),
      outputLocation:
          $enumDecode(_$OutputLocationEnumMap, json['output_location']),
      aspectRatio: $enumDecode(_$ImageAspectRatioEnumMap, json['aspect_ratio']),
    );

Map<String, dynamic> _$TattooRequestToJson(TattooRequest instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'style': TattooRequest._styleToJson(instance.style),
      'output_location': TattooRequest._locationToJson(instance.outputLocation),
      'aspect_ratio': TattooRequest._ratioToJson(instance.aspectRatio),
    };

const _$TattooStyleEnumMap = {
  TattooStyle.blackwork: 'blackwork',
  TattooStyle.geometric: 'geometric',
  TattooStyle.minimalist: 'minimalist',
};

const _$OutputLocationEnumMap = {
  OutputLocation.leg: 'leg',
  OutputLocation.back: 'back',
  OutputLocation.whitepaper: 'whitepaper',
};

const _$ImageAspectRatioEnumMap = {
  ImageAspectRatio.square: 'square',
  ImageAspectRatio.portrait: 'portrait',
  ImageAspectRatio.landscape: 'landscape',
};
