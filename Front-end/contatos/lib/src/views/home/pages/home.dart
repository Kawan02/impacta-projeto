import 'dart:convert';
import 'package:contatos/src/routes/pages_routes/app_pages.dart';
import 'package:contatos/src/services/components/custom_text_form_field.dart';
import 'package:contatos/src/services/load.dart';
import 'package:contatos/src/views/home/controllers/contatos_controller.dart';
import 'package:contatos/src/views/edit_contato/pages/edit_contatos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem == "imageDefault") return const AssetImage("assets/imgs/foto.png");

    return MemoryImage(base64Decode(imagem));
  }

  Color favorito(bool? favorito) {
    if (favorito == null || favorito == false) return Colors.white;

    return Colors.yellow;
  }

  Object tagImg(String? image) {
    if (image == null || image.isEmpty) return "imgDefault";

    return image;
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
                      child: GetBuilder<ContatosController>(
                        init: Get.find<ContatosController>(),
                        builder: (controller) {
                          return CustomTextField(
                            onTapOutside: (event) => FocusScope.of(context).unfocus(),
                            controller: controller.searchController,
                            textInputAction: TextInputAction.done,
                            validator: (controller) {
                              if (controller == null || controller.isEmpty) {
                                return "Esse campo é obrigatorio";
                              }

                              return null;
                            },
                            prefixIcon: const Icon(Icons.search_rounded),
                            labelText: "Pesquisar",
                            hintText: "Pesquise por nome, telefone ou sobrenome",
                            onChanged: (value) async => await controller.filterContacts(value),
                            isDense: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  controller.searchController.clear();
                                  await controller.filterContacts("");
                                },
                                child: Visibility(
                                  visible: controller.searchController.text.isNotEmpty,
                                  child: const Icon(Icons.close_rounded),
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          );
                        },
                      ),
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
                      itemBuilder: (_, index) {
                        final contatos = controller.contatos[index];

                        return Hero(
                          tag: tagImg(contatos.image),
                          child: Card(
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
                                        GestureDetector(
                                          child: Icon(
                                            Icons.star,
                                            size: 20,
                                            color: favorito(controller.favorito.value),
                                          ),
                                          onTap: () async {
                                            await controller.favoritos();
                                            await controller.putFavoritos(contatos.id!, controller.favorito.value);
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
                                        GestureDetector(
                                          child: Icon(Icons.star, size: 20, color: favorito(controller.favorito.value)),
                                          onTap: () async => controller.favoritos(),
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
      floatingActionButton: FloatingActionButton(
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
