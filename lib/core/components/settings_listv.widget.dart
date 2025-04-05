// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retcam/core/bloc/image/image.bloc.dart';
import 'package:retcam/core/bloc/settings/settings.bloc.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/theme/theme.provider.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

class SettingsListvWidget extends StatefulWidget {
  const SettingsListvWidget({super.key});

  @override
  State<SettingsListvWidget> createState() => _SettingsListvWidgetState();
}

class _SettingsListvWidgetState extends State<SettingsListvWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final setTitle = [
      LocaleKeys.settings_page_settings_page_darkmode.locale,
      LocaleKeys.settings_page_settings_page_language.locale,
      LocaleKeys.settings_page_settings_page_delete_data.locale,
    ];
    const setIcon = [Icons.dark_mode, Icons.language, Icons.delete];
    final setSubtitle = [
      LocaleKeys.settings_page_settings_page_darkmode_subtitle.locale,
      LocaleKeys.settings_page_settings_page_language_subtitle.locale,
      LocaleKeys.settings_page_settings_page_delete_data_subtitle.locale,
    ];
    const setColorIcon = [Colors.black, Colors.blue, Colors.red];

    return Expanded(
      child: ListView.builder(
        itemCount: setTitle.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            shadowColor: Colors.grey.withOpacity(0.2),
            color: Colors.white,
            child: ListTile(
              title: Text(setTitle[index]),
              subtitle: Text(setSubtitle[index]),
              leading: Icon(
                setIcon[index],
                color: setColorIcon[index],
                size: 30,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                // Handle setting tap
                if (index == 0) {
                  themeProvider.toggleTheme();
                  // Toggle dark mode
                } else if (index == 1) {
                  context.read<SettingsCubit>().setLanguage(context);
                  // Change language
                } else if (index == 2) {
                  await context.read<ImageCubit>().clearedAllImage(context);
                  // Delete all data
                }
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: Colors.white,
              selectedTileColor: Colors.grey.shade200,
              selected: false,

              visualDensity: VisualDensity.adaptivePlatformDensity,
              horizontalTitleGap: 0,
              minVerticalPadding: 10,
              minLeadingWidth: 0,
              dense: true,
              iconColor: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
