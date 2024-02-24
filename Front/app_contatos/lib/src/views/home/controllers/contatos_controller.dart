import 'package:app_contatos/src/routes/api_routes.dart';
import 'package:app_contatos/src/services/mensagerias/mensagem.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:core';

class ContatosController extends GetxController {
  final contatos = <ContatosModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingFilter = false.obs;

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
}
