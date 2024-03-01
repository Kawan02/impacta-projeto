import 'package:app_contatos/src/routes/api_routes.dart';
import 'package:app_contatos/src/routes/pages_routes/app_pages.dart';
import 'package:app_contatos/src/services/mensagerias/mensagem.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:core';

class ContatosController extends GetxController {
  final contatos = <ContatosModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingFilter = false.obs;
  final RxBool favorito = false.obs;

  Future<void> fetchUsers() async {
    isLoadingFilter.value == true ? null : isLoading.value = true;
    final dio = Dio();

    await dio.get(ApiRoutes.getContatos).then((response) {
      final List<dynamic> jsonList = response.data;
      contatos.assignAll(jsonList.map((json) => ContatosModel.fromJson(json)).toList());
    }, onError: (error) {
      mensageria(title: "Atenção", message: error.toString(), isError: true);
    });
    isLoadingFilter.value == true ? null : isLoading.value = false;
  }

  Future<void> filterContacts(String query) async {
    isLoadingFilter.value = true;
    if (query.isEmpty) {
      await fetchUsers();
      isLoadingFilter.value = false;
    }

    contatos.value = contatos.where(
      (filter) {
        return filter.nome!.toLowerCase().contains(query.toLowerCase()) || filter.telephone!.toLowerCase().contains(query.toLowerCase());
      },
    ).toList();

    isLoadingFilter.value = false;
  }

  Future<void> favoritos() async {
    favorito.value = !favorito.value;
  }

  Future<void> putFavoritos(int id, bool star) async {
    final dio = Dio();

    if (id == 0) {
      return mensageria(title: "Atenção", message: "Ocorreu um erro inesperado", isError: true);
    }

    await dio.put(ApiRoutes.putContato(id), data: ContatosModel(favorito: star).toJson()).then((response) async {
      if (response.statusCode == 200) {
        // await mensageria(title: "Atenção", message: "Contato atualizado com sucesso!", isError: false);
        await Get.offAllNamed(PagesRoutes.baseRoute);
      }
    }, onError: (error) {
      mensageria(title: "Atenção", message: error.toString(), isError: true);
    });
    isLoadingFilter.value == true ? null : isLoading.value = false;
  }
}
