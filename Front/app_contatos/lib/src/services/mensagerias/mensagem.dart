import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController mensageria({
  required String title,
  required String message,
  required bool isError,
}) {
  return Get.snackbar(
    title,
    message,
    borderRadius: 20,
    icon: Icon(isError ? Icons.error : Icons.check_circle),
    animationDuration: const Duration(milliseconds: 3000),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
    colorText: Colors.white,
    backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade500,
    duration: const Duration(milliseconds: 10000),
  );
}
