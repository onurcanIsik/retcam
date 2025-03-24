import 'package:auto_route/auto_route.dart';
import 'package:retcam/core/utils/enums/router.enums.dart';
import 'package:retcam/core/utils/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashPage.page,
      path: RouteEnums.splashPath.value,
      initial: true,
    ),
    AutoRoute(page: HomePage.page, path: RouteEnums.homePath.value),
  ];
}
