import 'package:get/get.dart';

class EditContatoController extends GetxController {
  RxString selectedItem = "".obs;

  // final List<String> favoritosOpcoes = ["Sim", "Não"].obs;

  void escolha(String? opcao) {
    if (opcao != null || opcao!.isNotEmpty) {
      selectedItem.value = opcao;
    }
  }
}
