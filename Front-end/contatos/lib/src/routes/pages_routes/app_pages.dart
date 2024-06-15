import 'package:contatos/src/views/add_contato/pages/add_contato.dart';
import 'package:contatos/src/views/home/pages/favoritos.dart';
import 'package:contatos/src/views/home/pages/home.dart';
import 'package:contatos/src/views/navigator/pages/navigator.dart';
import 'package:contatos/src/views/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const NavigatorPage(),
    ),
    GetPage(
      name: PagesRoutes.homeRoute,
      page: () => HomePage(),
    ),
    GetPage(
      name: PagesRoutes.addContatoRoute,
      page: () => AddContatosPage(),
    ),
    GetPage(
      name: PagesRoutes.favoritoRoute,
      page: () => FavoritosPage(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = "/splash";
  static const String baseRoute = "/";
  static const String favoritoRoute = "/favoritos";
  static const String homeRoute = "/home";
  static const String addContatoRoute = "/adicionar/contato";
  static const String editContatoRoute = "/edit/contatos";
}
