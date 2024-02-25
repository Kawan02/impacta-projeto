import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

Uint8List getStorageImage(String nome) {
  final box = GetStorage("imageCache");
  var result = box.read(nome);
  if (result != null) {
    return result;
  }
  return Uint8List(0);
}

void saveStorageImage(Uint8List value, String nome) {
  final box = GetStorage("imageCache");
  box.write(nome, value).val(nome);
}

void removeStorageImage(String nome) {
  final box = GetStorage("imageCache");
  box.remove(nome);
  box.save();
  print(nome);
  print(box);
}
