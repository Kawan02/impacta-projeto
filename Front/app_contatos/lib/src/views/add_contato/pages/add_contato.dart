import 'dart:convert';

import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/services/load.dart';
import 'package:app_contatos/src/views/add_contato/controllers/add_contato_controller.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:app_contatos/src/views/home/pages/home.dart';
import 'package:app_contatos/src/views/navigator/pages/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddContatosPage extends StatelessWidget {
  const AddContatosPage({super.key});

  static List<String> favoritosOpcoes = ["Sim", "Não"];
  static TextEditingController controllerNome = TextEditingController();
  static TextEditingController controllerSobrenome = TextEditingController();
  static TextEditingController controllerTelefone = TextEditingController();
  static TextEditingController controllerDtaNascimento = TextEditingController();
  static TextEditingController controllerNotas = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey();

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem.isEmpty) {
      return const AssetImage("assets/imgs/foto.png");
    }

    return MemoryImage(base64Decode(imagem));
  }

  Future<void> createContato(AddContatoController controller) async {
    ContatosModel model = ContatosModel(
      nome: controllerNome.text,
      favorito: controller.favorito.value,
      image: controller.image.value,
      sobrenome: controllerSobrenome.text,
      telephone: controllerTelefone.text,
      amigo: controller.selectedItem.value,
      dtaNascimento: controllerDtaNascimento.text,
      nota: controllerNotas.text,
    );

    await controller.createContato(model);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastrar Contato",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    width: size.width * 0.5,
                    height: size.height * 0.3,
                    child: GetX<AddContatoController>(
                      builder: (controller) {
                        if (controller.isLoading.value) return const Load();

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              image: imagem(controller.image.value),
                            ),
                          ),
                        );
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ir na galeria
                    GetBuilder<AddContatoController>(
                      init: Get.find<AddContatoController>(),
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
                    GetBuilder<AddContatoController>(
                      init: Get.find<AddContatoController>(),
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
                      controller: controllerNome,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      controller: controllerSobrenome,
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

                  // Data de nascimento
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerDtaNascimento,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.calendar_month),
                      labelText: "Data",
                      hintText: "Digite a data de nascimento",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  // GetX<AddContatoController>(
                  //   init: Get.find<AddContatoController>(),
                  //   builder: (controller) {
                  //     return GestureDetector(
                  //       child: Icon(
                  //         Icons.star,
                  //         color: !controller.favorito.value ? Colors.white : Colors.yellow,
                  //       ),
                  //       onTap: () => controller.favoritos(),
                  //     );
                  //   },
                  // ),

                  // Telefone
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerTelefone,
                      keyboardType: TextInputType.number,
                      validator: (controller) {
                        if (controller == null || controller.isEmpty) {
                          return "O telefone é obrigátorio";
                        }

                        return null;
                      },
                      prefixIcon: const Icon(Icons.phone),
                      labelText: "Telefone",
                      hintText: "Digite um telefone",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  // DropDown de Favoritos
                  GetX<AddContatoController>(
                    init: Get.find<AddContatoController>(),
                    builder: (controller) {
                      return DropdownButtonFormField<String>(
                        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                        elevation: 0,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        borderRadius: BorderRadius.circular(18),
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
                        hint: const Text("Adicionar a listas de favoritos"),
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
                      );
                    },
                  ),

                  // Notas
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerNotas,
                      keyboardType: TextInputType.text,
                      labelText: "Nota",
                      hintText: "Digite uma nota para esse contato",
                      minLines: 5,
                      maxLines: 10,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    child: GetBuilder<AddContatoController>(
                      init: Get.find<AddContatoController>(),
                      builder: (controller) {
                        if (controller.isLoading.value) return const Load();

                        return SizedBox(
                          height: 45,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.isLoading.value ? Colors.grey : Colors.blue[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await createContato(controller);
                              }
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Criar contato"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
