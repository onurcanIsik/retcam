import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retcam/core/bloc/home/hive_images.bloc.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

@RoutePage()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(LocaleKeys.homepage_history_page_title.locale),
        actions: [
          IconButton(
            onPressed: () {
              context.read<HiveImagesCubit>().getAllImages();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocListener<HiveImagesCubit, HiveImagesState>(
        listener: (context, state) {
          if (state is HiveImagesError) {
            context.showFailureSnackBar(state.message);
          }
        },
        child: Column(
          children: [
            BlocBuilder<HiveImagesCubit, HiveImagesState>(
              builder: (context, state) {
                if (state is HiveImagesLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is HiveImagesLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        final imagePath = state.images[index];
                        final file = File(imagePath);
                        if (file.existsSync()) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap:
                                  () =>
                                      context.imageDetail(imagePath: imagePath),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap:
                                  () =>
                                      context.imageDetail(imagePath: imagePath),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
