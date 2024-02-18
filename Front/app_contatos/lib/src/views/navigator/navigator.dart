import 'package:app_contatos/src/views/home/pages/favoritos.dart';
import 'package:app_contatos/src/views/home/pages/home.dart';
import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contatos",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomePage(),
          FavoritosPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 700),
              curve: Curves.linear,
            );
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[800],
        unselectedItemColor: Colors.white.withAlpha(120),
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Contatos",
            tooltip: "Contatos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoritos",
            tooltip: "Favoritos",
          ),
        ],
      ),
    );
  }
}
