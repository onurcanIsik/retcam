// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:retcam/colors/colors.dart';
import 'package:retcam/core/bloc/home/hive_images.bloc.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.sizeOf(this).width * val;
  double dynamicHeight(double val) => MediaQuery.sizeOf(this).height * val;

  ThemeData get theme => Theme.of(this);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAll => EdgeInsets.all(dynamicHeight(0.01));
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: dynamicHeight(0.01));
  EdgeInsets get paddingTop => EdgeInsets.only(top: dynamicHeight(0.01));
  EdgeInsets get paddingLeft => EdgeInsets.only(left: dynamicHeight(0.01));
  EdgeInsets get paddingRight => EdgeInsets.only(right: dynamicHeight(0.01));
}

extension StringLocalization on String {
  String get locale => this.tr();
}

extension SnackBarExtension on BuildContext {
  Future<void> showFailureSnackBar(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          label: LocaleKeys.homepage_back_txt.locale,
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> showSuccessSnackBar(String message) async {
    if (!mounted) return; // Check if the widget is still mounted
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          textColor: Colors.white,
          backgroundColor: Colors.black38,
          label: LocaleKeys.homepage_back_txt.locale,
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> showImageDialog({
    required String imagePath,
    String? newImagePath,
  }) async {
    if (!mounted) return;
    await showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          actions: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(newImagePath ?? imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(this);
                  },
                  child: Text(LocaleKeys.homepage_close_txt.locale),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAllImageExt() async {
    if (!mounted) return;
    await showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(
            LocaleKeys.settings_page_settings_page_delete_data.locale,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    context.read<HiveImagesCubit>().clearAllImages();
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    LocaleKeys.homepage_yes_txt.locale,
                    style: TextStyle(color: bgColor),
                  ),
                ),
                const Gap(20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(backgroundColor: mainRedColor),
                  child: Text(
                    LocaleKeys.homepage_no_txt.locale,
                    style: TextStyle(color: bgColor),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> imageDetail({required String? imagePath}) async {
    if (!mounted) return;
    await showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            Column(
              children: [
                const Gap(20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(imagePath ?? ''), fit: BoxFit.cover),
                ),
                const Gap(20),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await context.read<HiveImagesCubit>().saveToGallery(
                          imagePath!,
                          context,
                        );
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainBrownColor,
                      ),
                      child: Text(
                        LocaleKeys.homepage_download_txt.locale,
                        style: TextStyle(color: bgColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await context
                            .read<HiveImagesCubit>()
                            .deletePickedImages(imagePath!);
                        Navigator.pop(context);
                        await context.read<HiveImagesCubit>().getAllImages();
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        LocaleKeys.homepage_delete_txt.locale,
                        style: TextStyle(color: bgColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
