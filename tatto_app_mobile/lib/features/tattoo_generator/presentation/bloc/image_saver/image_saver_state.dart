import 'package:equatable/equatable.dart';

abstract class ImageSaverState extends Equatable {
  const ImageSaverState();
  
  @override
  List<Object> get props => [];
}

class ImageSaverInitial extends ImageSaverState {}

class ImageSaverLoading extends ImageSaverState {}

class ImageSaverSuccess extends ImageSaverState {}

class ImageSaverError extends ImageSaverState {
  final String message;

  const ImageSaverError({required this.message});

  @override
  List<Object> get props => [message];
}
