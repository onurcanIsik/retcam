import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:retcam/core/bloc/home/hive_images.bloc.dart';
import 'package:retcam/core/bloc/image/image.bloc.dart';
import 'package:retcam/core/bloc/settings/settings.bloc.dart';
import 'package:retcam/core/constant/constant.dart';
import 'package:retcam/core/theme/theme.provider.dart';
import 'package:retcam/core/theme/thems.dart';
import 'package:retcam/core/utils/localization/language.manager.dart';
import 'package:retcam/core/utils/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: ApplicationConstants.LANG_ASSET_PATH,
      fallbackLocale: LanguageManager.instance.supportedLocales.first,
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageCubit>(create: (context) => ImageCubit()),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
        BlocProvider<HiveImagesCubit>(
          create: (context) => HiveImagesCubit()..getAllImages(),
        ),
      ],
      child: MaterialApp.router(
        theme:
            themeProvider.isDarkMode
                ? ThemsClass().darkTheme
                : ThemsClass().lightTheme,
        routerDelegate: appRouter.delegate(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
