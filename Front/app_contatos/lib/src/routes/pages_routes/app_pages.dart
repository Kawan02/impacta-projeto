import 'package:app_contatos/src/views/home/pages/favoritos.dart';
import 'package:app_contatos/src/views/home/pages/home.dart';
import 'package:app_contatos/src/views/navigator/pages/navigator.dart';
import 'package:app_contatos/src/views/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.navigatorRoute,
      page: () => const NavigatorPage(),
    ),
    GetPage(
      name: PagesRoutes.homeRoute,
      page: () => const HomePage(),
    ),
    GetPage(
      name: PagesRoutes.favoritoRoute,
      page: () => const FavoritosPage(),
    ),
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = "/splash";
  static const String baseRoute = "/";
  static const String navigatorRoute = "/";
  static const String favoritoRoute = "/favoritos";
  static const String homeRoute = "/home";
}
