import 'dart:convert';
import 'package:app_contatos/src/routes/pages_routes/app_pages.dart';
import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/services/load.dart';
import 'package:app_contatos/src/views/add_contato/controllers/add_contato_controller.dart';
import 'package:app_contatos/src/views/home/controllers/contatos_controller.dart';
import 'package:app_contatos/src/views/edit_contato/pages/edit_contatos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final controllerFilter = Get.find<ContatosController>();

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem == "imageDefault") return const AssetImage("assets/imgs/foto.png");

    return MemoryImage(base64Decode(imagem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                    child: Form(
                      key: _formKey,
                      child: Obx(() {
                        return CustomTextField(
                          controller: textController,
                          textInputAction: TextInputAction.done,
                          validator: (controller) {
                            if (controller == null || controller.isEmpty) {
                              return "Esse campo é obrigatorio";
                            }

                            return null;
                          },
                          prefixIcon: const Icon(Icons.search_rounded),
                          labelText: "Pesquisar",
                          hintText: "Pesquise por nome ou telefone",
                          onChanged: (value) async => await controllerFilter.filterContacts(value),
                          suffixIcon: Visibility(
                            visible: controllerFilter.isLoadingFilter.value,
                            child: Container(
                              padding: const EdgeInsets.only(right: 20),
                              child: const CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GetX<ContatosController>(
            init: Get.find<ContatosController>(),
            initState: (state) {
              Future.delayed(Duration.zero, () {
                state.controller?.fetchUsers();
              });
            },
            builder: (controller) {
              if (controller.isLoading.value) {
                return const Expanded(
                  child: Load(),
                );
              }

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => await controller.fetchUsers(),
                  child: Visibility(
                    visible: controller.contatos.isNotEmpty,
                    replacement: const Center(
                      child: Text("Contato(s) não encontrado(s)"),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(color: Colors.grey.shade600),
                      ),
                      itemCount: controller.contatos.length,
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final contatos = controller.contatos[index];

                        return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                await Get.to(
                                  EditContatosPage(model: contatos),
                                  routeName: PagesRoutes.editContatoRoute,
                                  curve: Easing.linear,
                                  transition: Transition.zoom,
                                );
                              },
                              child: ListTile(
                                title: Visibility(
                                  visible: contatos.sobrenome == null || contatos.sobrenome!.isEmpty,
                                  replacement: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${contatos.nome} ${contatos.sobrenome}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      // Favoritos
                                      GetX<AddContatoController>(
                                        init: Get.find<AddContatoController>(),
                                        builder: (controller) {
                                          return GestureDetector(
                                            child: Icon(
                                              Icons.star,
                                              size: 20,
                                              color: !controller.favorito.value ? Colors.white : Colors.yellow,
                                            ),
                                            onTap: () async => await controller.favoritos(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          contatos.nome!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      // Favoritos
                                      GetX<AddContatoController>(
                                        init: Get.find<AddContatoController>(),
                                        builder: (controller) {
                                          return GestureDetector(
                                            child: Icon(
                                              Icons.star,
                                              size: 20,
                                              color: !controller.favorito.value ? Colors.white : Colors.yellow,
                                            ),
                                            onTap: () async => await controller.favoritos(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imagem(contatos.image),
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  contatos.telephone!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: IconButton(
                                  // Botão de editar
                                  onPressed: () async {
                                    await Get.to(
                                      EditContatosPage(model: contatos),
                                      routeName: PagesRoutes.editContatoRoute,
                                      curve: Easing.linear,
                                      transition: Transition.zoom,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: "btnAddContato",
        hoverColor: Colors.blue[800],
        backgroundColor: Colors.blue[800],
        splashColor: Colors.blue[800],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        // Botão de adicionar contatos
        onPressed: () async => await Get.toNamed(PagesRoutes.addContatoRoute),
        tooltip: 'Adicionar contatos',
        child: const Icon(
          Icons.person_add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
