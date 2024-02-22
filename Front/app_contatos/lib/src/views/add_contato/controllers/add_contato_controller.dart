import 'dart:convert';
import 'package:app_contatos/src/routes/api_routes.dart';
import 'package:app_contatos/src/services/mensagerias/mensagem.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddContatoController extends GetxController {
  RxString selectedItem = "".obs;
  RxString image = "".obs;
  RxBool isLoading = false.obs;
  RxBool favorito = false.obs;

  Future<void> createContato(ContatosModel model) async {
    isLoading.value = true;
    final dio = Dio();
    await dio.post(ApiRoutes.postContatos, data: model.toJson()).then((value) async {
      if (value.statusCode == 200) {
        mensageria(title: "Atenção", message: "Contato criado com sucesso!", isError: false);
        await Get.toNamed("/");
      }
    }, onError: (error) {
      mensageria(title: "Atenção", message: error.toString(), isError: true);
    });
    isLoading.value = false;
  }

  void escolha(String? opcao) {
    if (opcao != null || opcao!.isNotEmpty) {
      selectedItem.value = opcao;
    }
  }

  Future<void> getImagem() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      isLoading.value = true;
      final bytes = await pickedFile.readAsBytes();
      image.value = base64Encode(bytes);
    }
    isLoading.value = false;
  }

  Future<void> favoritos(ContatosModel model) async {
    favorito.value = !favorito.value;
  }
}