// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:retcam/core/components/home_card_comp.dart';
import 'package:retcam/core/utils/enums/router.enums.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Image.asset('assets/images/retcamLogo.png', scale: 12),
            Text(
              'Retcam',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.router.pushNamed(RouteEnums.settingsPath.value);
            },
          ),
        ],
      ),
      body: Column(children: [HomeCardWidget()]),
    );
  }
}
