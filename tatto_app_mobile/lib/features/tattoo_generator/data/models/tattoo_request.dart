import 'package:json_annotation/json_annotation.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';

part 'tattoo_request.g.dart';

@JsonSerializable()
class TattooRequest {
  final String prompt;
  @JsonKey(name: 'style', toJson: _styleToJson)
  final TattooStyle style;
  @JsonKey(name: 'output_location', toJson: _locationToJson)
  final OutputLocation outputLocation;
  @JsonKey(name: 'aspect_ratio', toJson: _ratioToJson)
  final ImageAspectRatio aspectRatio;

  const TattooRequest({
    required this.prompt,
    required this.style,
    required this.outputLocation,
    required this.aspectRatio,
  });

  factory TattooRequest.fromJson(Map<String, dynamic> json) => _$TattooRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TattooRequestToJson(this);

  static String _styleToJson(TattooStyle style) => style.toString().split('.').last;

  static String _locationToJson(OutputLocation location) => location.toString().split('.').last;

  static String _ratioToJson(ImageAspectRatio ratio) => ratio.toJsonValue();
}
