import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/service/image/Image.service.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImageService _imageService = ImageService();

  ImageCubit() : super(ImageInitial());

  Future<void> getImage(BuildContext context, ImageSource imageSource) async {
    emit(ImageLoading());
    final result = await _imageService.getImage(imageSource);

    result.fold(
      (failure) {
        context.showFailureSnackBar(failure);
        emit(ImageError(failure));
      },
      (imagePath) {
        emit(ImageLoaded(imagePath));
      },
    );
  }

  Future<void> applyEffect(String imagePath, BuildContext context) async {
    emit(ImageEffectInProgress());

    final service = await _imageService.applyFilter(imagePath);

    service.fold(
      (failure) {
        context.showFailureSnackBar(failure);
        emit(ImageError(failure));
      },
      (successImagePath) {
        emit(ImageEffectInDone());
        emit(ImageLoaded(successImagePath));
      },
    );
  }

  Future<void> removeImage(BuildContext context, String? imagePath) async {
    emit(ImageRemoving());
    final result = await _imageService.removeImage(imagePath);

    result.fold(
      (failure) {
        context.showFailureSnackBar(failure);
        emit(ImageError(failure));
      },
      (successMessage) async {
        context.showSuccessSnackBar(successMessage);
        emit(ImageInitial());
      },
    );
  }

  Future<void> clearedAllImage(BuildContext context) async {
    emit(ImageRemoving());
    final result = await _imageService.clearSavedImages();

    result.fold(
      (failure) {
        context.showFailureSnackBar(failure);
        emit(ImageError(failure));
      },
      (successMessage) async {
        context.showSuccessSnackBar(LocaleKeys.homepage_done_txt.locale);
        emit(ImageInitial());
      },
    );
  }
}

abstract class ImageState {}

class ImageEffectInProgress extends ImageState {}

class ImageEffectInDone extends ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final String imagePath;
  ImageLoaded(this.imagePath);
}

class ImageRemoving extends ImageState {}

class ImageError extends ImageState {
  final String error;
  ImageError(this.error);
}
