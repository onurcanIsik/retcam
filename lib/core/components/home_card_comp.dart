// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:retcam/colors/colors.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/utils/enums/router.enums.dart';

class HomeCardWidget extends StatefulWidget {
  const HomeCardWidget({super.key});

  @override
  State<HomeCardWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends State<HomeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.1,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                index == 0
                    ? context.router.pushNamed(RouteEnums.cameraPath.value)
                    : index == 1
                    ? context.router.pushNamed(RouteEnums.galleryPath.value)
                    : context.router.pushNamed(RouteEnums.historyPath.value);
              },
              child: Container(
                height: context.dynamicHeight(0.2),
                width: context.dynamicWidth(0.4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                  color:
                      index == 0
                          ? mainRedColor
                          : index == 1
                          ? mainBrownColor
                          : mainYellowColor,
                ),
                child: Center(
                  child:
                      index == 0
                          ? Icon(Icons.camera_alt, size: 50)
                          : index == 1
                          ? Icon(Icons.image, size: 50)
                          : Icon(Icons.history, size: 50),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
