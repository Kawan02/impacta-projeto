import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorController extends GetxController {
  final currentIndex = 0.obs;
  final pageController = PageController().obs;

  void getMenu(int value) {
    currentIndex.value = value;
    pageController.value.animateToPage(
      value,
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
    );
    update();
  }
}
