// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retcam/core/bloc/image/image.bloc.dart';
import 'package:retcam/core/components/filter_btn_widget.dart';
import 'package:retcam/core/components/gallery_image_card.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

@RoutePage()
class CameraPage extends HookWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isClicked = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(centerTitle: false, elevation: 0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GalleryImageCard(
              imageSource: ImageSource.camera,
              icon: Icons.camera,
            ),
            const Gap(20),
            FilterButtonWidget(() async {
              final imageState = context.read<ImageCubit>().state;
              if (imageState is ImageLoaded && !isClicked.value) {
                final imagePath = imageState.imagePath;
                isClicked.value = true;
                await context.read<ImageCubit>().applyEffect(
                  imagePath,
                  context,
                );

                await context.read<ImageCubit>().removeImage(
                  context,
                  imagePath,
                );
                isClicked.value = false;
              } else {
                context.showFailureSnackBar(
                  LocaleKeys.error_image_cant_download.locale,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
