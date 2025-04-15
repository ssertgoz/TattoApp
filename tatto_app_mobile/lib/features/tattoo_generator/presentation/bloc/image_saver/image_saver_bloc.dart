import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/save_tattoo_to_gallery.dart';
import 'image_saver_event.dart';
import 'image_saver_state.dart';

class ImageSaverBloc extends Bloc<ImageSaverEvent, ImageSaverState> {
  final SaveTattooToGallery saveTattooToGallery;

  ImageSaverBloc({
    required this.saveTattooToGallery,
  }) : super(ImageSaverInitial()) {
    on<SaveImageEvent>(_onSaveImage);
  }

  Future<void> _onSaveImage(
    SaveImageEvent event,
    Emitter<ImageSaverState> emit,
  ) async {
    emit(ImageSaverLoading());

    final result = await saveTattooToGallery(event.imageUrl);

    result.fold(
      (failure) => emit(ImageSaverError(message: failure.message)),
      (success) => emit(ImageSaverSuccess()),
    );
  }
}
