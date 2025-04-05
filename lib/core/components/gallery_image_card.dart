// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retcam/core/bloc/image/image.bloc.dart';
import 'package:retcam/core/extensions/extensions.dart';

class GalleryImageCard extends StatelessWidget {
  final ImageSource imageSource;
  final IconData icon;
  const GalleryImageCard({
    super.key,
    required this.imageSource,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        Widget child;

        if (state is ImageLoading) {
          child = const CircularProgressIndicator();
        } else if (state is ImageLoaded) {
          child = Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(state.imagePath),
                  fit: BoxFit.cover,
                  width: context.dynamicWidth(0.8),
                  height: context.dynamicHeight(0.4),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () async {
                    await context.read<ImageCubit>().removeImage(
                      context,
                      state.imagePath,
                    );
                  },
                  icon: const Icon(Icons.close, size: 30),
                ),
              ),
            ],
          );
        } else if (state is ImageInitial || state is ImageError) {
          child = IconButton(
            onPressed: () {
              context.read<ImageCubit>().getImage(context, imageSource);
            },
            icon: Icon(icon, size: 50),
          );
        } else {
          child = const SizedBox();
        }

        return Center(
          child: Container(
            height: context.dynamicHeight(0.4),
            width: context.dynamicWidth(0.8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(child: child),
          ),
        );
      },
    );
  }
}
