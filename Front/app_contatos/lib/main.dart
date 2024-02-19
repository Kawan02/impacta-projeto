import 'package:app_contatos/src/routes/pages_routes/app_pages.dart';
import 'package:app_contatos/src/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  DependecyInjection.init();

  // WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Contatos",
      defaultTransition: Transition.native,
      // translations: MyTranslations(),
      locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[800]!),
        useMaterial3: true,
      ),
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
      // home: const NavigatorPage(),
    );
  }
}
