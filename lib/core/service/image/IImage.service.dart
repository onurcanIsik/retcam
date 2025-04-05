import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageService {
  Future<Either<String, String>> getImage(ImageSource imageSource);
  Future<Either<String, String>> applyFilter(String imagePath);
  Future<Either<String, String>> removeImage(String? imagePath);
  Future<Either<String, String>> saveImage(String imagePath);
  Future<Either<String, Unit>> clearSavedImages();
  Future<Either<String, List<String>>> getSavedImages();
  Future<Either<String, Unit>> deletePickedImage(String imagePath);
  Future<Either<String, Unit>> saveImageToGallery(String imagePath);
}
