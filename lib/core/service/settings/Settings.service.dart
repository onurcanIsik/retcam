import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:dartz/dartz.dart';
import 'package:retcam/core/service/settings/ISettings.service.dart';

class SettingsService implements ISettingsService {
  @override
  Future<Either<Unit, Unit>> setLanguage() async {
    // todo: implement setLanguage
    try {
      const intent = AndroidIntent(
        action: 'android.settings.LOCALE_SETTINGS',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      await intent.launch();
      return right(unit);
    } catch (e) {
      return left(unit);
    }
  }
}
