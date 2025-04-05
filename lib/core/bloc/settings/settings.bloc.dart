import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/service/settings/Settings.service.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService settingsService = SettingsService();
  setLanguage(BuildContext context) async {
    final result = await settingsService.setLanguage();
    result.fold(
      (failure) => context.showFailureSnackBar(
        '${LocaleKeys.error_error_txt.locale}: $failure',
      ),
      (success) => null,
    );
  }

  SettingsCubit() : super(SettingsInitial());
}

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
