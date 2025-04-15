import 'package:equatable/equatable.dart';

abstract class ImageSaverEvent extends Equatable {
  const ImageSaverEvent();

  @override
  List<Object> get props => [];
}

class SaveImageEvent extends ImageSaverEvent {
  final String imageUrl;

  const SaveImageEvent({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
