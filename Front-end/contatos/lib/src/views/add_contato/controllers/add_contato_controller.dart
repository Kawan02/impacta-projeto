import 'dart:convert';
import 'package:contatos/src/routes/api_routes.dart';
import 'package:contatos/src/routes/pages_routes/app_pages.dart';
import 'package:contatos/src/services/components/valid_size_image.dart';
import 'package:contatos/src/services/mensagerias/mensagem.dart';
import 'package:contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddContatoController extends GetxController {
  final RxString selectedItem = "".obs;
  final RxString image = "".obs;
  final RxBool isLoading = false.obs;
  final RxBool favorito = false.obs;

  Future<void> createContato(ContatosModel model) async {
    isLoading.value = true;
    final dio = Dio();
    await dio.post(ApiRoutes.postContatos, data: model.toJson()).then((response) async {
      if (response.statusCode == 200) {
        await mensageria(title: "Atenção", message: "Contato criado com sucesso!", isError: false);
        await Get.offAllNamed(PagesRoutes.baseRoute);
      }
    }, onError: (error) {
      mensageria(title: "Atenção", message: error.toString(), isError: true);
    });
    isLoading.value = false;
  }

  String escolha(String? opcao) {
    if (opcao != null || opcao!.isNotEmpty) return selectedItem.value = opcao;

    return "";
  }

  bool star(bool star) {
    if (selectedItem.value == "Sim") return star = true;

    return star = false;
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
