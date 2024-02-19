import 'package:app_contatos/src/routes/api_routes.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContatosController extends GetxController {
  final contatos = <ContatosModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      final dio = Dio();
      final response = await dio.get(ApiRoutes.getContatos);
      final List<dynamic> jsonList = response.data;
      contatos.assignAll(jsonList.map((json) => ContatosModel.fromJson(json)).toList());
    } catch (e) {
      throw Exception(e.toString());
    }
    isLoading.value = false;
  }
}
