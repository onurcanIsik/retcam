// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retcam/colors/colors.dart';
import 'package:retcam/core/manager/shared.manager.dart';
import 'package:retcam/core/utils/enums/router.enums.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return EasySplashScreen(
            logo: Image.asset('assets/images/retcamLogo.png'),
            logoWidth: 100,
            loaderColor: mainRedColor,
            loadingText: Text('V1.0.0'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Future<void> _initializeApp(BuildContext context) async {
    await Future.wait([SharedManager.init(), Hive.initFlutter()]);
    await Future.delayed(Duration(seconds: 4));

    Hive.openBox('userBox');

    context.router.replacePath(RouteEnums.homePath.value);
  }
}
