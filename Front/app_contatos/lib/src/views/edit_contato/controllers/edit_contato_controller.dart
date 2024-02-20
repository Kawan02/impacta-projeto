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
    // isLoading.value = true;
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      isLoading.value = true;
      print(pickedFile.path);
      final bytes = await pickedFile.readAsBytes();
      // _base64Image = base64Encode(bytes);
      image.value = pickedFile.path;
    }
    isLoading.value = false;
    update(["imagem"]);
  }
}
