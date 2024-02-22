import 'dart:convert';

import 'package:app_contatos/src/services/components/valid_size_image.dart';
import 'package:app_contatos/src/services/mensagerias/mensagem.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditContatoController extends GetxController {
  RxString selectedItem = "".obs;
  RxString image = "".obs;
  RxBool isLoading = false.obs;

  void escolha(String? opcao) {
    if (opcao != null || opcao!.isNotEmpty) {
      selectedItem.value = opcao;
    }
    // update(["favoritos"]);
  }

  Future<void> getImagem() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var result = await validFileSize(filepath: pickedFile);
      if (result != true) {
        mensageria(title: "Atenção", message: "Arquivo maior que o limite permitido de (2mb)", isError: true);
        return;
      }

      isLoading.value = true;
      final bytes = await pickedFile.readAsBytes();
      image.value = base64Encode(bytes);
    }
    isLoading.value = false;
  }
}
