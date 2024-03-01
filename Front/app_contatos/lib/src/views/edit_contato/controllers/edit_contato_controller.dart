import 'dart:convert';
import 'package:app_contatos/src/routes/api_routes.dart';
import 'package:app_contatos/src/routes/pages_routes/app_pages.dart';
import 'package:app_contatos/src/services/components/valid_size_image.dart';
import 'package:app_contatos/src/services/mensagerias/mensagem.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditContatoController extends GetxController {
  RxString selectedItem = "".obs;
  RxString image = "".obs;
  RxBool isLoading = false.obs;
  final RxBool favorito = false.obs;

  Future<void> putContato(int id, ContatosModel model) async {
    isLoading.value = true;

    final dio = Dio();

    await dio.put(ApiRoutes.putContato(id), data: model.toJson()).then((response) async {
      if (response.statusCode == 200) {
        await mensageria(title: "Atenção", message: "Contato atualizado com sucesso!", isError: false);
        await Get.offAllNamed(PagesRoutes.baseRoute);
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
