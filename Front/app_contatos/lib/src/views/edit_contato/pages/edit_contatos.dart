import 'dart:convert';

import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/services/load.dart';
import 'package:app_contatos/src/views/edit_contato/controllers/edit_contato_controller.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditContatosPage extends StatelessWidget {
  final ContatosModel model;
  const EditContatosPage({
    super.key,
    required this.model,
  });

  static List<String> favoritosOpcoes = ["Sim", "Não"];
  static TextEditingController controllerNome = TextEditingController();

  ImageProvider<Object> imagem(String? imagem, String? imagemSelecionada) {
    // if ((imagemSelecionada == "" && imagem == "Default") || imagemSelecionada == "") {
    //   return const AssetImage("assets/imgs/foto.png");
    // }
    if (imagem == "Default") {
      return const AssetImage("assets/imgs/foto.png");
    }

    if (imagemSelecionada != null || imagemSelecionada!.isNotEmpty || imagemSelecionada == "") {
      print(imagemSelecionada);
      // return MemoryImage(base64Decode(imagem!));
      return const AssetImage("assets/imgs/foto.png");
    }
    return MemoryImage(base64Decode(imagem!));
  }

  // String? image = "";
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Atualizar Contato",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 20),
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                  child: GetX<EditContatoController>(
                    builder: (controller) {
                      if (controller.isLoading.value) return const Load();

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                            image: imagem(model.image, controller.image.value),
                          ),
                        ),
                      );
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ir na galeria
                  GetBuilder<EditContatoController>(
                    init: Get.find<EditContatoController>(),
                    builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: FloatingActionButton.small(
                          heroTag: "btnAddFoto",
                          backgroundColor: Colors.blue[800],
                          tooltip: "Adicionar foto",
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.photo_library_rounded),
                          onPressed: () async => await controller.getImagem(),
                        ),
                      );
                    },
                  ),
                  // Remover foto
                  GetBuilder<EditContatoController>(
                    init: Get.find<EditContatoController>(),
                    builder: (controller) {
                      return FloatingActionButton.small(
                        heroTag: "btnRemoveFoto",
                        backgroundColor: Colors.red[800],
                        tooltip: "Remover foto",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.delete),
                        onPressed: () => controller.image.value = "",
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                // Nome
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  child: CustomTextField(
                    // controller: controllerNome = TextEditingController(text: model.nome),
                    initialValue: model.nome,
                    keyboardType: TextInputType.text,
                    validator: (controller) {
                      if (controller == null || controller.isEmpty) {
                        return "O nome é obrigátorio";
                      }

                      return null;
                    },
                    prefixIcon: const Icon(Icons.person),
                    labelText: "Nome",
                    hintText: "Digite um nome aqui",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                // Sobrenome
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: CustomTextField(
                    initialValue: model.sobrenome,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.person),
                    labelText: "Sobrenome",
                    hintText: "Digite seu sobrenome",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                // Telefone
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: CustomTextField(
                    initialValue: model.telephone,
                    keyboardType: TextInputType.number,
                    validator: (controller) {
                      if (controller == null || controller.isEmpty) {
                        return "O telefone é obrigatorio";
                      }

                      return null;
                    },
                    prefixIcon: const Icon(Icons.phone),
                    labelText: "Telefone",
                    hintText: "Digite um telefone",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                // DropDown de Favoritos
                GetX<EditContatoController>(
                  init: Get.find<EditContatoController>(),
                  builder: (controller) {
                    return DropdownButtonFormField<String>(
                      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      iconSize: 40,
                      icon: const Icon(Icons.arrow_drop_down),
                      itemHeight: 50,
                      isExpanded: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Selecione um item da lista";
                        }
                        return null;
                      },
                      iconEnabledColor: Colors.blue[800],
                      hint: Visibility(
                        visible: model.amigo!.isEmpty,
                        replacement: Text(
                          model.amigo!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Text("Adicionar a listas de favoritos"),
                      ),
                      value: controller.selectedItem.value.isEmpty ? null : controller.selectedItem.value,
                      items: favoritosOpcoes.map(
                        (opcao) {
                          return DropdownMenuItem<String>(
                            value: opcao,
                            child: Text(opcao),
                          );
                        },
                      ).toList(),
                      onChanged: (value) => controller.escolha(value),
                      // onChanged: (escolha) {
                      //   setState(() {
                      //     selectedItem = escolha!;
                      //   });
                      // },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
