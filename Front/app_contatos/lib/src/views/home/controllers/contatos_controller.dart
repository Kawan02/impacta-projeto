import 'package:app_contatos/src/routes/api_routes.dart';
import 'package:app_contatos/src/services/mensagerias/mensagem.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContatosController extends GetxController {
  final contatos = <ContatosModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchUsers() async {
    isLoading.value = true;
    final dio = Dio();

    await dio.get(ApiRoutes.getContatos).then((response) {
      final List<dynamic> jsonList = response.data;
      contatos.assignAll(jsonList.map((json) => ContatosModel.fromJson(json)).toList());
    }, onError: (error) {
      mensageria(title: "Atenção", message: error.toString(), isError: true);
    });
    isLoading.value = false;
  }

  // @override
  // void onInit() {
  //   fetchUsers();
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   fetchUsers();
  //   super.onClose();
  // }
}
