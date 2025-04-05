import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/service/image/Image.service.dart';

class HiveImagesCubit extends Cubit<HiveImagesState> {
  final ImageService _imageService = ImageService();
  HiveImagesCubit() : super(HiveImagesInitial());

  getAllImages() async {
    emit(HiveImagesLoading());
    final service = await _imageService.getSavedImages();

    service.fold(
      (isFailure) => emit(HiveImagesError(isFailure)),

      (isSuccess) => emit(HiveImagesLoaded(isSuccess)),
    );
  }

  clearAllImages() async {
    final service = await _imageService.clearSavedImages();

    service.fold(
      (isFailure) => emit(HiveImagesError(isFailure)),
      (isSuccess) => emit(HiveImagesLoaded([])),
    );
  }

  deletePickedImages(String imagePath) async {
    final service = await _imageService.deletePickedImage(imagePath);

    service.fold(
      (isFailure) => emit(HiveImagesError(isFailure)),
      (isSuccess) => emit(HiveImagesLoaded([])),
    );
  }

  saveToGallery(String imagePath, BuildContext context) async {
    final service = await _imageService.saveImageToGallery(imagePath);

    service.fold(
      (isFailure) {
        print(isFailure);
        return context.showFailureSnackBar(isFailure);
      },
      (isSuccess) {
        return context.showSuccessSnackBar('Done');
      },
    );
  }
}

abstract class HiveImagesState {}

class HiveImagesInitial extends HiveImagesState {}

class HiveImagesLoading extends HiveImagesState {}

class HiveImagesError extends HiveImagesState {
  final String message;
  HiveImagesError(this.message);
}

class HiveImagesLoaded extends HiveImagesState {
  final List<String> images;
  HiveImagesLoaded(this.images);
}
