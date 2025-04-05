import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/service/image/IImage.service.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import 'package:retcam/core/utils/localization/locale_keys.g.dart';

class ImageService implements IImageService {
  final ImagePicker picker = ImagePicker();

  @override
  Future<Either<String, String>> getImage(ImageSource imageSource) async {
    try {
      final XFile? image = await picker.pickImage(source: imageSource);
      if (image == null) {
        return left(LocaleKeys.error_image_cant_download.locale);
      }
      final imageSrc = image.path;
      return right(imageSrc);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }

  @override
  Future<Either<String, String>> applyFilter(String imagePath) async {
    try {
      final file = File(imagePath);
      final imageBytes = file.readAsBytesSync();
      final originalImage = img.decodeImage(Uint8List.fromList(imageBytes));
      if (originalImage == null) {
        return left(LocaleKeys.error_error_txt.locale);
      }
      final retroImage = img.copyResize(originalImage, width: 600);
      img.adjustColor(
        retroImage,
        contrast: 1.3,
        brightness: 0.8,
        saturation: 0.4,
        gamma: 2.0,
        exposure: -0.3,
        hue: 0.05,
      );
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final filteredImagePath =
          '${file.parent.path}/filtered_image_$timestamp.jpg';
      final _ = File(filteredImagePath)
        ..writeAsBytesSync(img.encodeJpg(retroImage));
      await saveImage(filteredImagePath);

      return right(filteredImagePath);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }

  @override
  Future<Either<String, String>> removeImage(String? imagePath) async {
    try {
      if (imagePath == null || !File(imagePath).existsSync()) {
        return left(LocaleKeys.error_image_cant_download.locale);
      }
      final imageFile = File(imagePath);
      await imageFile.delete();
      imagePath = null;
      return right(LocaleKeys.homepage_done_txt.locale);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }

  @override
  Future<Either<String, String>> saveImage(String imagePath) async {
    try {
      var userImageBox = Hive.box('userImageBox');
      List<String> savedImages = List<String>.from(
        userImageBox.get('images', defaultValue: []),
      );
      savedImages.add(imagePath);
      await userImageBox.put('images', savedImages);
      return right(LocaleKeys.homepage_done_txt.locale);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }

  @override
  Future<Either<String, Unit>> clearSavedImages() async {
    try {
      var userImageBox = Hive.box('userImageBox');
      await userImageBox.delete('images');
      return right(unit);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }

  @override
  Future<Either<String, List<String>>> getSavedImages() async {
    try {
      var userImageBox = Hive.box('userImageBox');
      List<dynamic> rawList = userImageBox.get('images', defaultValue: []);
      List<String> images = List<String>.from(rawList);
      return right(images);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }

  @override
  Future<Either<String, Unit>> deletePickedImage(String imagePath) async {
    try {
      var userImageBox = Hive.box('userImageBox');
      List<String> images = userImageBox.get('images', defaultValue: []);
      if (images.contains(imagePath)) {
        images.remove(imagePath);
        await userImageBox.put('images', images);

        // Fiziksel olarak da sil
        File file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
        }
        return right(unit);
      }
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Unit>> saveImageToGallery(String imagePath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = imagePath.split('/').last;
      final newFilePath = '${directory.path}/$fileName';

      final file = File(imagePath);
      await file.copy(newFilePath);

      final _ = await ImageGallerySaverPlus.saveFile(newFilePath);
      return right(unit);
    } catch (ex) {
      return left('${LocaleKeys.error_error_txt.locale}: $ex');
    }
  }
}
