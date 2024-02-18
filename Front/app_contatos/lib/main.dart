import 'package:app_contatos/src/views/home/pages/home.dart';
import 'package:app_contatos/src/views/navigator/navigator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Contatos",
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      // darkTheme: ThemeData.dark(),
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue[800]!,
        ),
        useMaterial3: true,
      ),
      home: const NavigatorPage(),
    );
  }
}
