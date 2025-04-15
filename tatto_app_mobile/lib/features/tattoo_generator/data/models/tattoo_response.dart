import 'package:json_annotation/json_annotation.dart';

part 'tattoo_response.g.dart';

@JsonSerializable()
class TattooResponse {
  @JsonKey(name: 'image_url')
  final String imageUrl;

  TattooResponse({required this.imageUrl});

  factory TattooResponse.fromJson(Map<String, dynamic> json) =>
      _$TattooResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TattooResponseToJson(this);
}
