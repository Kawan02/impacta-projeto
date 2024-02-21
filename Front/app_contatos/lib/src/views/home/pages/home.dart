import 'dart:convert';
import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/services/load.dart';
import 'package:app_contatos/src/views/home/controllers/contatos_controller.dart';
import 'package:app_contatos/src/views/edit_contato/pages/edit_contatos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> consultar() async {
    // FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      return;
    }

    // return;
  }

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem.isEmpty) return const AssetImage("assets/imgs/foto.png");

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
                      child: CustomTextField(
                        controller: textController,
                        validator: (controller) {
                          if (controller == null || controller.isEmpty) {
                            return "Esse campo é obrigatorio";
                          }

                          return null;
                        },
                        prefixIcon: const Icon(Icons.person),
                        labelText: "Pesquise por nome",
                        hintText: "Digite um nome aqui...",
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.only(right: 5),
                          onPressed: () async {
                            await consultar();
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 25,
                            semanticLabel: "Pesquisar",
                          ),
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
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
                      child: Text("Não tem nenhum contatos salvos"),
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
                                  routeName: "/edit/contatos",
                                  curve: Easing.linear,
                                  transition: Transition.zoom,
                                );
                              },
                              child: ListTile(
                                title: Visibility(
                                  visible: contatos.sobrenome != null || contatos.sobrenome!.isNotEmpty,
                                  replacement: Text(
                                    contatos.nome!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${contatos.nome!} ${contatos.sobrenome!}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      // Favoritos
                                      // GetX<AddContatoController>(
                                      //   init: Get.find<AddContatoController>(),
                                      //   builder: (controller) {
                                      //     return GestureDetector(
                                      //         child: Icon(
                                      //           Icons.star,
                                      //           color: !controller.favorito.value ? Colors.white : Colors.yellow,
                                      //         ),
                                      //         onTap: () {});
                                      //   },
                                      // ),
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
                                        image: imagem(contatos.image!),
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
                                      routeName: "/edit/contatos",
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
        onPressed: () async => await Get.toNamed("/adicionar/contato"),
        tooltip: 'Adicionar contatos',
        child: const Icon(
          Icons.person_add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
