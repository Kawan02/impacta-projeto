import 'package:contatos/src/views/home/pages/favoritos.dart';
import 'package:contatos/src/views/home/pages/home.dart';
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: FloatingActionButton.small(
              hoverColor: Colors.red.shade600,
              backgroundColor: Colors.red.shade600,
              splashColor: Colors.red.shade600,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                // Botão de excluir todos os contatos
              },
              tooltip: "Excluir todos os contatos?",
              child: const Icon(Icons.delete),
            ),
          ),
        ],
        title: const Text(
          "Agenda de Contatos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomePage(),
          const FavoritosPage(),
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
        backgroundColor: Colors.grey[800],
        unselectedItemColor: Colors.white.withAlpha(120),
        selectedItemColor: Colors.blue[600],
        elevation: 0,
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
