// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:retcam/core/components/settings_listv.widget.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/retcamLogo.png', scale: 12),
            Text(
              LocaleKeys.settings_page_settings_page_title.locale,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
      ),
      body: Column(children: [SettingsListvWidget()]),
    );
  }
}
