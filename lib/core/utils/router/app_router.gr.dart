// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:retcam/pages/home/homepage.dart' as _i1;
import 'package:retcam/pages/splash/splash.dart' as _i2;

/// generated route for
/// [_i1.HomePage]
class HomePage extends _i3.PageRouteInfo<void> {
  const HomePage({List<_i3.PageRouteInfo>? children})
    : super(HomePage.name, initialChildren: children);

  static const String name = 'HomePage';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.SplashPage]
class SplashPage extends _i3.PageRouteInfo<void> {
  const SplashPage({List<_i3.PageRouteInfo>? children})
    : super(SplashPage.name, initialChildren: children);

  static const String name = 'SplashPage';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.SplashPage();
    },
  );
}
