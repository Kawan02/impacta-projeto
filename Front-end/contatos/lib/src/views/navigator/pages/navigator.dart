import 'package:contatos/src/views/home/pages/favoritos.dart';
import 'package:contatos/src/views/home/pages/home.dart';
import 'package:contatos/src/views/navigator/controllers/navigator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
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
      body: GetBuilder<NavigatorController>(
        init: Get.find<NavigatorController>(),
        builder: (controller) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController.value,
            children: [
              HomePage(),
              const FavoritosPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        child: GetBuilder<NavigatorController>(
          init: Get.find<NavigatorController>(),
          builder: (controller) {
            return NavigationBar(
              selectedIndex: controller.currentIndex.value,
              backgroundColor: Colors.grey[800],
              animationDuration: const Duration(milliseconds: 2000),
              indicatorColor: Colors.blue[800],
              elevation: 0,
              onDestinationSelected: (value) => controller.getMenu(value),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.person_3_outlined, size: 30),
                  selectedIcon: Icon(Icons.person_3, size: 30),
                  label: "Contatos",
                  tooltip: "Contatos",
                ),
                NavigationDestination(
                  icon: Icon(Icons.star_border, size: 30),
                  selectedIcon: Icon(Icons.star, size: 30),
                  label: "Favoritos",
                  tooltip: "Favoritos",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
